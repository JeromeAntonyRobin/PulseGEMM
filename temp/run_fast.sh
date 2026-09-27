#!/bin/bash
export PATH=/home/ubuntu/GEMMCNN/temp/lib:$PATH
export LD_LIBRARY_PATH=/home/ubuntu/GEMMCNN/temp/lib/32/lib/i386-linux-gnu:/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/libfp:/home/ubuntu/GEMMCNN/temp/lib/usr/lib/x86_64-linux-gnu:/home/ubuntu/GEMMCNN/temp/lib/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LM_LICENSE_FILE=1702@ubuntu
export SNPSLMD_LICENSE_FILE=1702@ubuntu
cd /home/ubuntu/GEMMCNN/temp/ref_design
/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/bin64/libero SCRIPT:/home/ubuntu/GEMMCNN/temp/run_synth_pr_only.tcl
