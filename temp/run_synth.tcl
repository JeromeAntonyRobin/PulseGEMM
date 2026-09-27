open_project -file {/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/MPFS_DISCOVERY.prjx}
clean_tool -name {SYNTHESIZE}
run_tool -name {SYNTHESIZE} -params {NUM_CORES:4}
save_project
close_project
