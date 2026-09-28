#!/bin/bash
export PATH=/home/ubuntu/PulseGEMM/temp/lib:$PATH
export LD_LIBRARY_PATH=/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/libfp:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LM_LICENSE_FILE=1702@ubuntu
export SNPSLMD_LICENSE_FILE=1702@ubuntu

mkdir -p /home/ubuntu/PulseGEMM/temp/fp_prog_2

echo "============================================================"
echo "    Flashing PolarFire SoC Discovery Kit FPGA Bitstream     "
echo "============================================================"

/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/bin64/FPExpress script:/home/ubuntu/PulseGEMM/tcl/prog.tcl
