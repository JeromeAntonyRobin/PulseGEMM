open_project -project {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top_fp/gemm_top.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {MPFS095T} \
    -fpga {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top.map} \
    -header {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top.hdr} \
    -snvm {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top_snvm.efc} \
    -spm {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top.spm} \
    -dca {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top.dca}
export_single_ppd \
    -name {MPFS095T} \
    -file {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top.ppd}

save_project
close_project
