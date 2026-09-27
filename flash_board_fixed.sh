#!/bin/bash
export PATH=/home/ubuntu/GEMMCNN/temp/lib:$PATH
export LD_LIBRARY_PATH=/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/libfp:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LM_LICENSE_FILE=1702@ubuntu
export SNPSLMD_LICENSE_FILE=1702@ubuntu
mkdir -p /home/ubuntu/GEMMCNN/temp/fp_prog_2
/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/bin64/FPExpress script:/home/ubuntu/GEMMCNN/temp/prog.tcl
