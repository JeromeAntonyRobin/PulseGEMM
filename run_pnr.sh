#!/bin/bash
echo "============================================================"
echo "   Running Libero SoC Batch Synthesis & Place and Route     "
echo "============================================================"
echo "[*] Executing tcl/run_pnr.tcl script..."

mkdir -p doc/synthesis_logs

/home/ubuntu/microchip/Libero_SoC_2026.1/Libero/bin64/libero SCRIPT:tcl/run_pnr.tcl LOGFILE:doc/synthesis_logs/libero_pnr.log

if [ $? -eq 0 ]; then
    echo "[+] PnR Flow completed! Log saved to doc/synthesis_logs/libero_pnr.log"
else
    echo "[!] PnR Flow encountered issues. Check doc/synthesis_logs/libero_pnr.log"
fi
