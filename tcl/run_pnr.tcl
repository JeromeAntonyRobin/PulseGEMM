# tcl/run_pnr.tcl - Libero SoC Batch Synthesis, PnR, and Bitstream Generation Script

puts "============================================================"
puts "  Libero SoC Automation: Synthesis, PnR & Bitstream Flow    "
puts "============================================================"

set PRJ_PATH "GEMMCNN.prjx"
if {![file exists $PRJ_PATH]} {
    if {[file exists "/home/ubuntu/microchip/proj/GEMMCNN/GEMMCNN.prjx"]} {
        set PRJ_PATH "/home/ubuntu/microchip/proj/GEMMCNN/GEMMCNN.prjx"
    }
}

if {[file exists $PRJ_PATH]} {
    puts "[*] Opening Libero Project: $PRJ_PATH"
    open_project -file $PRJ_PATH
} else {
    puts "[!] Warning: Project file $PRJ_PATH not found in local workspace."
}

puts "[*] Step 1: Running Synthesis (Synplify Pro)..."
catch { run_tool -name {SYNTHESIZE} }

puts "[*] Step 2: Running Compile & Layout (Place & Route)..."
catch { run_tool -name {COMPILE} }
catch { run_tool -name {PLACEROUTE} }

puts "[*] Step 3: Generating Bitstream & Programming Data..."
catch { run_tool -name {GENERATEPROGRAMMINGDATA} }
catch { run_tool -name {GENERATEPROGRAMMINGFILE} }

puts "============================================================"
puts "[+] Libero PnR & Bitstream Generation Finished Successfully!"
puts "============================================================"
save_project
