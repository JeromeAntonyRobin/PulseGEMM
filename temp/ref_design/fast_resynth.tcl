open_project -file {MPFS_DISCOVERY/MPFS_DISCOVERY.prjx}
configure_tool -name {PLACEROUTE} -params {EFFORT_LEVEL:false} -params {MULTI_PASS_LAYOUT:false} = params {NUM_MULTI_PASSES:1}
run_tool -name {SYNTHESIZE}
run_tool -name {PLACEROUTE}
run_tool -name {VERIFYTIMING}
run_tool -name {GENERATEPROGRAMMINGDATA}
export_prog_job \
    -job_file_name {MPFS_DISCOVERY} \
    -export_dir {.} \
    -design_bitstream_format {PPD} \
    -program_fabric 1 \
    -program_snvm 1
save_project
close_project
