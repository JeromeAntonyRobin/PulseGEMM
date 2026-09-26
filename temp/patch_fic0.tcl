# Add GEMM_DMA_TOP instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {gemm_dma_top} -instance_name {GEMM_DMA_TOP}

# Connect clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"ACLK" "GEMM_DMA_TOP:clk"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARESETN" "GEMM_DMA_TOP:rst_n"}

# Connect AXI4-Lite control interface from FIC0_INITIATOR to GEMM_DMA_TOP
# FIC0_INITIATOR has AXI4mslave2 now since we changed NUM_SLAVES to 3
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIC0_INITIATOR:AXI4mslave2" "GEMM_DMA_TOP:s_axi"}

# Connect AXI4 Master interface from GEMM_DMA_TOP to DMA_INITIATOR
# DMA_INITIATOR has AXI4mmaster1 now since we changed NUM_MASTERS to 2
sd_connect_pins -sd_name ${sd_name} -pin_names {"GEMM_DMA_TOP:m_axi" "DMA_INITIATOR:AXI4mmaster1"}

# Expose GEMM_DMA_TOP IRQ or LEDs if needed (we can leave them disconnected or promote them)
# sd_mark_pins_unused -sd_name ${sd_name} -pin_names {"GEMM_DMA_TOP:irq" "GEMM_DMA_TOP:led_busy" "GEMM_DMA_TOP:led_done"}
