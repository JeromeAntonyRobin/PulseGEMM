#!/bin/bash
export LM_LICENSE_FILE=/home/ubuntu/.local/share/microsemi/license/License.dat
export SNPSLMD_LICENSE_FILE=/home/ubuntu/.local/share/microsemi/license/License.dat

echo "============================================================"
echo "   Running Libero SoC Batch Synthesis & Place and Route     "
echo "============================================================"
echo "[*] Executing tcl/run_pnr.tcl script..."

mkdir -p doc/synthesis_logs

LIBERO_BIN="/home/ubuntu/microchip/Libero_SoC_2026.1/Libero_SoC/Designer/bin64/libero"

if [ -x "$LIBERO_BIN" ]; then
    "$LIBERO_BIN" SCRIPT:tcl/run_pnr.tcl LOGFILE:doc/synthesis_logs/libero_pnr.log
    if [ $? -eq 0 ]; then
        echo "[+] PnR Flow completed! Log saved to doc/synthesis_logs/libero_pnr.log"
    else
        echo "[!] PnR Flow encountered issues. Check doc/synthesis_logs/libero_pnr.log"
    fi
else
    echo "[!] Libero binary not found at $LIBERO_BIN"
    exit 1
fi
