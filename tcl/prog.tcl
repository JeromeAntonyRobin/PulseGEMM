open_project -project {/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top_fp/gemm_top.pro} -connect_programmers {TRUE}
load_programming_data \
    -name {MPFS095T} \
    -fpga {/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top.map} \
    -header {/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top.hdr} \
    -dca {/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top.dca}
run_selected_actions
close_project
