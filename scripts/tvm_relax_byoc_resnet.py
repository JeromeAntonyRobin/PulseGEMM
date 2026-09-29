import tvm
from tvm import relax
import onnx
import os

print("[*] TVM Relax BYOC Pipeline for PulseGEMM...")
onnx_model = onnx.load("sw/models/resnet50_pretrained.onnx")
print("[+] ONNX model loaded successfully!")

# Define BYOC pattern for Relax
# In TVM Relax, BYOC pattern matching is registered with relax.transform.FuseOpsByPattern
from tvm.relax.dpl import wildcard, is_op

def make_relax_conv2d_pattern():
    data = wildcard()
    weight = wildcard()
    conv = is_op("relax.nn.conv2d")(data, weight)
    relu = is_op("relax.nn.relu")(conv)
    return relu

print("[+] Relax BYOC pattern defined: [relax.nn.conv2d -> relax.nn.relu]")
