open_project -file {/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/MPFS_DISCOVERY.prjx}
run_tool -name {PLACEROUTE}
run_tool -name {VERIFYTIMING}
run_tool -name {GENERATEPROGRAMMINGDATA}
export_prog_job \
    -job_file_name {MPFS_DISCOVERY} \
    -export_dir {/home/ubuntu/GEMMCNN/temp/ref_design} \
    -design_bitstream_format {PPD} \
    -program_fabric 1 \
    -program_snvm 1
save_project
close_project
