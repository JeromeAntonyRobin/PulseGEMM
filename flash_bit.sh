#!/bin/bash
echo "============================================================"
echo "    Flashing PolarFire SoC Discovery Kit FPGA Bitstream     "
echo "============================================================"

BITSTREAM_DIR="bitstream"
JOB_FILE=$(find "$BITSTREAM_DIR" synthesis/ designer/ temp/ -name "*.pdb" -o -name "*.job" -o -name "*.bit" -o -name "*.hex" 2>/dev/null | head -n 1)

if [ -z "$JOB_FILE" ]; then
    echo "[!] No bitstream found in bitstream/ directory or build output."
    echo "[!] Run ./run_pnr.sh to generate the bitstream."
    exit 1
fi

echo "[*] Found bitstream file: $JOB_FILE"
echo "[*] Flashing bitstream to target board via Microchip Programmer..."

if [ -x "/home/ubuntu/microchip/Program_Debug_Tool_v2026.1/bin64/fpnpro" ]; then
    sudo /home/ubuntu/microchip/Program_Debug_Tool_v2026.1/bin64/fpnpro -script "$JOB_FILE"
else
    echo "[!] Microchip fpnpro tool not found at expected location."
    exit 1
fi
