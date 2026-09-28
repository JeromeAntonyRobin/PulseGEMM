#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_c_file>"
    exit 1
fi

SRC_FILE=$1
BASENAME=$(basename "$SRC_FILE" .c)
OUT_DIR="sw/demo/compiled"

mkdir -p "$OUT_DIR"
OUT_BIN="$OUT_DIR/$BASENAME"

read -t 1 -p "Username [root]: " USERNAME
USERNAME=${USERNAME:-root}
read -t 1 -p "IP Address [10.11.58.31]: " IP
IP=${IP:-10.11.58.31}
read -t 1 -s -p "Password [disco]: " PASSWORD
echo
PASSWORD=${PASSWORD:-disco}

echo "[*] Compiling $SRC_FILE -> $OUT_BIN..."
/home/ubuntu/microchip/Libero_SoC_2026.1/SmartHLS/SmartHLS/swtools/binutils/riscv-gnu-toolchain/bin/riscv64-unknown-linux-gnu-gcc -O3 -o "$OUT_BIN" "$SRC_FILE" sw/lib/gemmrv_hw.c -I sw/lib/
if [ $? -ne 0 ]; then
    echo "[!] Compilation failed!"
    exit 1
fi

echo "[*] Transferring $OUT_BIN to ${USERNAME}@${IP}:/root/..."
python3 -c "
import pexpect, sys
child = pexpect.spawn('scp -o StrictHostKeyChecking=no $OUT_BIN ${USERNAME}@${IP}:/root/')
idx = child.expect(['password:', 'assword:', pexpect.EOF])
if idx in [0, 1]:
    child.sendline('$PASSWORD')
    child.expect(pexpect.EOF)
"

echo "[*] Running $BASENAME on board..."
python3 -c "
import pexpect, sys
child = pexpect.spawn('ssh -o StrictHostKeyChecking=no ${USERNAME}@${IP} \"cd /root && chmod +x $BASENAME && ./$BASENAME\"')
idx = child.expect(['password:', 'assword:', pexpect.EOF])
if idx in [0, 1]:
    child.sendline('$PASSWORD')
    while True:
        try:
            sys.stdout.write(child.read_nonblocking(size=1024, timeout=2).decode('utf-8'))
            sys.stdout.flush()
        except pexpect.EOF:
            break
        except pexpect.TIMEOUT:
            continue
else:
    while True:
        try:
            sys.stdout.write(child.read_nonblocking(size=1024, timeout=2).decode('utf-8'))
            sys.stdout.flush()
        except pexpect.EOF:
            break
        except pexpect.TIMEOUT:
            continue
"
