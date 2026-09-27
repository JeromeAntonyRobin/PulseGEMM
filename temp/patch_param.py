import re

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'r') as f:
    code = f.read()

code = re.sub(r'parameter AXI_DATA_WIDTH = 32\n\)', r'parameter AXI_DATA_WIDTH = 32,\n    parameter M_AXI_DATA_WIDTH = 64\n)', code)

with open('/home/ubuntu/GEMMCNN/temp/ref_design/MPFS_DISCOVERY/hdl/gemm_dma_top.v', 'w') as f:
    f.write(code)
