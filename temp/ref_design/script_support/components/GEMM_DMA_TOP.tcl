create_hdl_core -file {hdl/gemm_dma_top.v} -module {gemm_dma_top} -library {work} -package {}

hdl_core_add_bif -hdl_core_name {gemm_dma_top} -bif_definition {AXI4:AMBA:AMBA4:slave} -bif_name {s_axi} -signal_map {\
"AWADDR:s_axi_awaddr" \
"AWVALID:s_axi_awvalid" \
"AWREADY:s_axi_awready" \
"WDATA:s_axi_wdata" \
"WSTRB:s_axi_wstrb" \
"WVALID:s_axi_wvalid" \
"WREADY:s_axi_wready" \
"BRESP:s_axi_bresp" \
"BVALID:s_axi_bvalid" \
"BREADY:s_axi_bready" \
"ARADDR:s_axi_araddr" \
"ARVALID:s_axi_arvalid" \
"ARREADY:s_axi_arready" \
"RDATA:s_axi_rdata" \
"RRESP:s_axi_rresp" \
"RVALID:s_axi_rvalid" \
"RREADY:s_axi_rready" }

hdl_core_add_bif -hdl_core_name {gemm_dma_top} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {m_axi} -signal_map {\
"AWADDR:m_axi_awaddr" \
"AWLEN:m_axi_awlen" \
"AWSIZE:m_axi_awsize" \
"AWBURST:m_axi_awburst" \
"AWLOCK:m_axi_awlock" \
"AWCACHE:m_axi_awcache" \
"AWPROT:m_axi_awprot" \
"AWQOS:m_axi_awqos" \
"AWVALID:m_axi_awvalid" \
"AWREADY:m_axi_awready" \
"WDATA:m_axi_wdata" \
"WSTRB:m_axi_wstrb" \
"WLAST:m_axi_wlast" \
"WVALID:m_axi_wvalid" \
"WREADY:m_axi_wready" \
"BRESP:m_axi_bresp" \
"BVALID:m_axi_bvalid" \
"BREADY:m_axi_bready" \
"ARADDR:m_axi_araddr" \
"ARLEN:m_axi_arlen" \
"ARSIZE:m_axi_arsize" \
"ARBURST:m_axi_arburst" \
"ARLOCK:m_axi_arlock" \
"ARCACHE:m_axi_arcache" \
"ARPROT:m_axi_arprot" \
"ARQOS:m_axi_arqos" \
"ARVALID:m_axi_arvalid" \
"ARREADY:m_axi_arready" \
"RDATA:m_axi_rdata" \
"RRESP:m_axi_rresp" \
"RLAST:m_axi_rlast" \
"RVALID:m_axi_rvalid" \
"RREADY:m_axi_rready" }
