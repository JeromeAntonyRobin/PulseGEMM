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

print("[*] Waking up console and logging in...")
ser.write(b"\n\n\n")
time.sleep(1)
out = ser.read(ser.in_waiting).decode('utf-8', errors='ignore')

if "login:" in out.lower():
    print("    Detected login prompt, sending 'root'...")
    ser.write(b"root\n")
    time.sleep(1)
    out = ser.read(ser.in_waiting).decode('utf-8', errors='ignore')
    if "password:" in out.lower():
        print("    Detected password prompt, sending 'disco'...")
        ser.write(b"disco\n")
        time.sleep(1)
        ser.read(ser.in_waiting)
    
ser.write(b"\x03\x03") # Ctrl-C
time.sleep(0.5)
ser.read(ser.in_waiting)

print(f"[*] Cleaning old files on board...")
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
ser.write(b"\x04") # Ctrl-D
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

t_end = time.time() + 15.0
while time.time() < t_end:
    if ser.in_waiting:
        out = ser.read(ser.in_waiting).decode('utf-8', errors='ignore')
        sys.stdout.write(out)
        sys.stdout.flush()
    time.sleep(0.1)

print("\n" + "="*65)
print("[*] Automation Complete! Closing port.")
ser.close()
