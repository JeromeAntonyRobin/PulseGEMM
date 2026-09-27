import re

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/component/work/FIC_0_PERIPHERALS/FIC_0_PERIPHERALS.v', 'r') as f:
    code = f.read()

# Replace assignments that slice 64-bit to 32-bit
code = re.sub(r'assign GEMM_DMA_TOP_m_axi_RDATA_0 = \{ GEMM_DMA_TOP_m_axi_RDATA_0_31to0 \};\nassign GEMM_DMA_TOP_m_axi_RDATA_0_31to0 = GEMM_DMA_TOP_m_axi_RDATA\[31:0\];', r'assign GEMM_DMA_TOP_m_axi_RDATA_0 = GEMM_DMA_TOP_m_axi_RDATA;', code)

code = re.sub(r'assign GEMM_DMA_TOP_m_axi_WDATA_0 = \{ GEMM_DMA_TOP_m_axi_WDATA_0_63to32, GEMM_DMA_TOP_m_axi_WDATA_0_31to0 \};\nassign GEMM_DMA_TOP_m_axi_WDATA_0_31to0 = GEMM_DMA_TOP_m_axi_WDATA\[31:0\];\nassign GEMM_DMA_TOP_m_axi_WDATA_0_63to32 = 32\'h0;', r'assign GEMM_DMA_TOP_m_axi_WDATA_0 = GEMM_DMA_TOP_m_axi_WDATA;', code)

code = re.sub(r'assign GEMM_DMA_TOP_m_axi_WSTRB_0 = \{ GEMM_DMA_TOP_m_axi_WSTRB_0_7to4, GEMM_DMA_TOP_m_axi_WSTRB_0_3to0 \};\nassign GEMM_DMA_TOP_m_axi_WSTRB_0_3to0 = GEMM_DMA_TOP_m_axi_WSTRB\[3:0\];\nassign GEMM_DMA_TOP_m_axi_WSTRB_0_7to4 = 4\'h0;', r'assign GEMM_DMA_TOP_m_axi_WSTRB_0 = GEMM_DMA_TOP_m_axi_WSTRB;', code)

# Update wire definitions if necessary
code = re.sub(r'wire\s+\[31:0\]\s+GEMM_DMA_TOP_m_axi_WDATA;', r'wire   [63:0] GEMM_DMA_TOP_m_axi_WDATA;', code)
code = re.sub(r'wire\s+\[31:0\]\s+GEMM_DMA_TOP_m_axi_RDATA_0;', r'wire   [63:0] GEMM_DMA_TOP_m_axi_RDATA_0;', code)

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/component/work/FIC_0_PERIPHERALS/FIC_0_PERIPHERALS.v', 'w') as f:
    f.write(code)
