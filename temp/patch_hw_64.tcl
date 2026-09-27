open_project -file {/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/MPFS_DISCOVERY.prjx}
update_component -name {FIC_0_PERIPHERALS}
build_design_hierarchy
clean_tool -name {SYNTHESIZE}
run_tool -name {SYNTHESIZE}
run_tool -name {PLACEROUTE}
export_prog_job \
    -job_file_name {MPFS_DISCOVERY} \
    -export_dir {/home/ubuntu/GEMMCNN/temp/ref_design} \
    -design_bitstream_format {PPD} \
    -bitstream_file_components {FABRIC SNVM}
save_project
close_project
