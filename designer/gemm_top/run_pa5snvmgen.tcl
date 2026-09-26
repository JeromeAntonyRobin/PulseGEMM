set_device \
    -fam PolarFireSoC \
    -die PA5SOC095T \
    -pkg fcsg325
set_input_cfg \
    -path {/home/ubuntu/GEMMCNN/designer/gemm_top/SNVM.cfg}
set_output_efc \
    -path {/home/ubuntu/GEMMCNN/designer/gemm_top/gemm_top_snvm.efc}
set_is_relative_path \
    -value {FALSE}
set_root_path_dir \
    -path {}
