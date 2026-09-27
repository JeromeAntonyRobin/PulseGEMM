open_project -file {/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/MPFS_DISCOVERY.prjx}
export_prog_job \
    -job_file_name {MPFS_DISCOVERY} \
    -export_dir {/home/ubuntu/GEMMCNN/temp/ref_design} \
    -design_bitstream_format {PPD} \
    -bitstream_file_components {FABRIC SNVM}
save_project
close_project
