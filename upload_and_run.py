#!/usr/bin/env python3
import time
import base64
import sys
import serial

if len(sys.argv) < 3:
    print("Usage: python3 upload_and_run.py <binary_path> <serial_port>")
    print("Example: python3 upload_and_run.py /home/ubuntu/GEMMCNN/temp/sw/demo_lenet /dev/ttyUSB0")
    sys.exit(1)

binary_path = sys.argv[1]
port = sys.argv[2]
bin_name = binary_path.split("/")[-1]

print(f"[*] Reading binary {binary_path}...")
with open(binary_path, "rb") as f:
    b64_data = base64.b64encode(f.read()).decode('utf-8')

try:
    ser = serial.Serial(port, 115200, timeout=0.5)
except Exception as e:
    print(f"ERROR: Could not open {port}. {e}")
    sys.exit(1)

def send_cmd(cmd, delay=0.5):
    ser.write(cmd.encode('utf-8') + b"\n")
    time.sleep(delay)
    while ser.in_waiting:
        ser.read(ser.in_waiting)

def read_available():
    time.sleep(0.3)
    return ser.read(ser.in_waiting).decode('utf-8', errors='ignore')

print("[*] Waking up console and waiting for boot/login prompt (up to 60s)...")
ser.write(b"\n\n\n")
deadline = time.time() + 60
state = "booting"
out_buffer = ""

while time.time() < deadline:
    chunk = read_available()
    if chunk:
        sys.stdout.write(chunk)
        sys.stdout.flush()
        out_buffer += chunk
    
    out_lower = out_buffer.lower()
    if "login:" in out_lower:
        print("\n    Detected login prompt, sending 'root'...")
        ser.write(b"root\n")
        time.sleep(1)
        out_buffer = ""
    elif "password:" in out_lower:
        print("    Detected password prompt, sending 'disco'...")
        ser.write(b"disco\n")
        time.sleep(1)
        out_buffer = ""
    elif "root@" in out_lower and "#" in out_lower:
        print("\n    Logged into Linux as root!")
        state = "linux_ready"
        break
    elif "risc-v #" in out_lower or "=>" in out_lower:
        if "login" not in out_lower:
            print("\n    Detected U-Boot prompt! Sending 'boot' to start Linux...")
            ser.write(b"boot\n")
            time.sleep(2)
            out_buffer = "" # reset and keep waiting for login

if state != "linux_ready":
    print("\nERROR: Failed to reach Linux root prompt. Aborting.")
    ser.close()
    sys.exit(1)

# --- Already logged in (root@...) - just Ctrl-C to clear any running cmd ---
ser.write(b"\x03\x03")
time.sleep(0.5)
ser.read(ser.in_waiting)

print("[*] Cleaning old files on board...")
send_cmd(f"rm -f {bin_name} app.b64")

print("[*] Starting file transfer (with strict flow control)...")
send_cmd("cat > app.b64")

chunk_size = 64
total_chunks = len(b64_data) // chunk_size + 1

for i in range(total_chunks):
    chunk = b64_data[i*chunk_size : (i+1)*chunk_size]
    if chunk:
        ser.write(chunk.encode('utf-8') + b"\n")
        time.sleep(0.02)
        if i % 100 == 0 or i == total_chunks - 1:
            print(f"    Progress: {i+1}/{total_chunks} chunks...")

print("[*] Finalizing file...")
time.sleep(0.5)
ser.write(b"\x04")  # Ctrl-D (EOF)
time.sleep(1.0)
while ser.in_waiting:
    ser.read(ser.in_waiting)

print(f"[*] Decoding and Executing {bin_name}...")
send_cmd(f"base64 -d app.b64 > {bin_name}", delay=1.0)
send_cmd(f"chmod +x {bin_name}")

ser.write(f"./{bin_name}\n".encode('utf-8'))

print("\n" + "="*65)
print(f"             EXECUTION OUTPUT ({bin_name})")
print("="*65)

t_end = time.time() + 90.0   # 90s window — plenty for LeNet + HW
last_output_t = time.time()
while time.time() < t_end:
    if ser.in_waiting:
        out = ser.read(ser.in_waiting).decode('utf-8', errors='ignore')
        sys.stdout.write(out)
        sys.stdout.flush()
        last_output_t = time.time()
        # Early exit: program finished and shell prompt returned
        if "root@" in out and "#" in out:
            time.sleep(0.5)
            if ser.in_waiting:
                sys.stdout.write(ser.read(ser.in_waiting).decode('utf-8', errors='ignore'))
            break
    elif time.time() - last_output_t > 40.0:
        print("\n[WARN] No output for 40s — program may be hung.")
        break
    time.sleep(0.1)

print("\n" + "="*65)
print("[*] Automation Complete! Closing port.")
ser.close()
