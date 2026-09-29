open_project -project {/home/ubuntu/PulseGEMM/build/designer/gemm_top/gemm_top_fp/gemm_top.pro} -connect_programmers {TRUE}

set_programming_action -name {MPFS095T} -action {PROGRAM}
run_selected_actions
close_project
