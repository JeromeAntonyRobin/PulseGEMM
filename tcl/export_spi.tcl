open_project -project {/home/ubuntu/PulseGEMM/build/PulseGEMM.prjx}
export_spiflash_image \
    -file_name {gemm_top_spi} \
    -export_dir {/home/ubuntu/PulseGEMM/bitstream/} \
    -design_version 1
close_project
