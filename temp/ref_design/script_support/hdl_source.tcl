#Importing and Linking all the HDL source files used in the design
import_files -library work -hdl_source hdl/apb_arbiter.v
import_files -library work -hdl_source hdl/APB_PASS_THROUGH.v
import_files -library work -hdl_source /home/ubuntu/GEMMCNN/hdl/gemm_pe.v
import_files -library work -hdl_source /home/ubuntu/GEMMCNN/hdl/gemm_skew_buffer.v
import_files -library work -hdl_source /home/ubuntu/GEMMCNN/hdl/gemm_systolic_core.v
import_files -library work -hdl_source /home/ubuntu/GEMMCNN/hdl/gemm_dma_top.v
