set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_verilog -mode system_verilog {/home/ubuntu/GEMMCNN/hdl/gemm_pe.v}
read_verilog -mode system_verilog {/home/ubuntu/GEMMCNN/hdl/gemm_systolic_core.v}
read_verilog -mode system_verilog {/home/ubuntu/GEMMCNN/hdl/gemm_axi_slave.v}
read_verilog -mode system_verilog {/home/ubuntu/GEMMCNN/hdl/gemm_top.v}
set_top_level {gemm_top}
map_netlist
check_constraints {/home/ubuntu/GEMMCNN/constraint/synthesis_sdc_errors.log}
write_fdc {/home/ubuntu/GEMMCNN/designer/gemm_top/synthesis.fdc}
