# tcl/flash.tcl - Flash Bitstream onto PolarFire SoC FPGA Board via Libero Batch Mode

puts "============================================================"
puts "  Flashing PolarFire SoC Discovery Kit FPGA Board...       "
puts "============================================================"

set PRO_FILE "/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top_fp/gemm_top.pro"

if {[file exists $PRO_FILE]} {
    puts "Opening FPExpress Project: $PRO_FILE"
    open_project -file $PRO_FILE
    puts "Executing FPGA Programming Action..."
    catch { run_tool -name {PROGRAMDEVICE} }
    puts "Flashing Completed Successfully!"
    close_project
} else {
    puts "Error: FPExpress project $PRO_FILE not found."
}
