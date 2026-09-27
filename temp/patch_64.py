import re

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'r') as f:
    code = f.read()

# Separate M_AXI and S_AXI widths
code = re.sub(r'parameter AXI_DATA_WIDTH = 64', r'parameter AXI_DATA_WIDTH = 32,\n    parameter M_AXI_DATA_WIDTH = 64', code)

# Update M_AXI ports
code = re.sub(r'output reg\s+\[AXI_DATA_WIDTH-1:0\]\s+m_axi_wdata', r'output reg  [M_AXI_DATA_WIDTH-1:0]    m_axi_wdata', code)
code = re.sub(r'input\s+wire\s+\[AXI_DATA_WIDTH-1:0\]\s+m_axi_rdata', r'input  wire [M_AXI_DATA_WIDTH-1:0]    m_axi_rdata', code)

# Fix WSTRB
code = re.sub(r'output reg\s+\[3:0\]\s+m_axi_wstrb', r'output reg  [7:0]                   m_axi_wstrb', code)
code = re.sub(r'm_axi_wstrb\s*<=\s*4\'h0;', r"m_axi_wstrb   <= 8'h0;", code)
code = re.sub(r'm_axi_wstrb\s*<=\s*4\'hF;', r"m_axi_wstrb   <= 8'h0F;", code)

# Fix WDATA writes
code = re.sub(r'm_axi_wdata\s*<=\s*mat_c_flat\[\(burst_idx\*64\)\*32 \+: 32\];', r"m_axi_wdata <= {32'd0, mat_c_flat[(burst_idx*64)*32 +: 32]};", code)
code = re.sub(r'm_axi_wdata\s*<=\s*mat_c_flat\[\(burst_idx\*64 \+ \(word_idx \+ 6\'d1\)\)\*32 \+: 32\];', r"m_axi_wdata <= {32'd0, mat_c_flat[(burst_idx*64 + (word_idx + 6'd1))*32 +: 32]};", code)
code = re.sub(r'm_axi_wdata\s*<=\s*32\'d0;', r"m_axi_wdata   <= 64'd0;", code)

# Fix RDATA reads
code = re.sub(r'mat_a_mem\[word_idx\]\s*<=\s*m_axi_rdata;', r"mat_a_mem[word_idx] <= m_axi_rdata[31:0];", code)
code = re.sub(r'mat_b_mem\[word_idx\]\s*<=\s*m_axi_rdata;', r"mat_b_mem[word_idx] <= m_axi_rdata[31:0];", code)

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'w') as f:
    f.write(code)
