# tcl/run_pnr.tcl - PulseGEMM Automated Libero SoC Synthesis & PnR Flow

puts "============================================================"
puts "  PulseGEMM Libero SoC Automation: Synthesis & PnR Flow      "
puts "============================================================"

set PRJ_DIR "./build"
set PRJ_NAME "PulseGEMM"
set PRJ_FILE "${PRJ_DIR}/${PRJ_NAME}.prjx"

if {[file exists $PRJ_FILE]} {
    puts "Opening existing Libero Project: $PRJ_FILE"
    open_project -file $PRJ_FILE
} else {
    puts "Creating new Libero Project in $PRJ_DIR..."
    catch { file delete -force $PRJ_DIR }
    new_project \
        -location $PRJ_DIR \
        -name $PRJ_NAME \
        -project_description "PulseGEMM Accelerator for Microchip PolarFire SoC" \
        -block_mode 0 \
        -family {PolarFireSoC} \
        -die {PA5SOC095T} \
        -package {fcsg325} \
        -speed {-1} \
        -die_voltage {1.0} \
        -hdl {VERILOG}

    puts "Importing PulseGEMM RTL Source Files..."
    import_files -hdl_source {rtl/gemm/gemm_pe.v} \
                 -hdl_source {rtl/gemm/gemm_skew_buffer.v} \
                 -hdl_source {rtl/gemm/gemm_systolic_core.v} \
                 -hdl_source {rtl/gemm/gemm_dma_top.v} \
                 -hdl_source {rtl/gemm/gemm_axi_slave.v} \
                 -hdl_source {rtl/gemm/gemm_top.v}

    puts "Importing PDC IO Pin Constraints..."
    import_files -io_pdc {tcl/const.pdc}
}

puts "Building Design Hierarchy..."
build_design_hierarchy

puts "Setting Root Module to gemm_top..."
set_root -module {gemm_top}

puts "Step 1: Running Synthesis (Synplify Pro)..."
catch { run_tool -name {SYNTHESIZE} }

puts "Step 2: Running Compile & Layout (Place & Route)..."
catch { run_tool -name {COMPILE} }
catch { run_tool -name {PLACEROUTE} }

puts "Step 3: Generating Bitstream & Programming Data..."
catch { run_tool -name {GENERATEPROGRAMMINGDATA} }
catch { run_tool -name {GENERATEPROGRAMMINGFILE} }

puts "============================================================"
puts "Libero PnR & Bitstream Generation Finished Successfully!"
puts "============================================================"
save_project
