import re

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'r') as f:
    code = f.read()

code = re.sub(r'output wire\s+\[3:0\]\s+m_axi_wstrb,', r'output wire [7:0]                   m_axi_wstrb,', code)
code = re.sub(r'assign m_axi_wstrb\s*=\s*4\'hF;', r"assign m_axi_wstrb   = 8'h0F;", code)
code = re.sub(r'm_axi_wdata\s*<=\s*mat_c_flat\[\(burst_idx\*64 \+ 0\)\*32 \+: 32\];', r"m_axi_wdata <= {32'd0, mat_c_flat[(burst_idx*64 + 0)*32 +: 32]};", code)

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'w') as f:
    f.write(code)
