new_project \
         -name {gemm_top} \
         -location {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS095T} \
         -name {MPFS095T}
enable_device \
         -name {MPFS095T} \
         -enable {TRUE}
save_project
close_project
