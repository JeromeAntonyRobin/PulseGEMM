import torch
import torchvision.models as models
import os

os.makedirs("sw/models", exist_ok=True)
onnx_path = "sw/models/resnet50_pretrained.onnx"

print("[*] Loading pretrained ResNet-50 for ONNX export...")
model = models.resnet50(weights=models.ResNet50_Weights.IMAGENET1K_V1)
model.eval()

dummy_input = torch.randn(1, 3, 224, 224)
print(f"[*] Exporting model to {onnx_path}...")
torch.onnx.export(
    model,
    dummy_input,
    onnx_path,
    input_names=["data"],
    output_names=["output"],
    opset_version=13
)
print(f"[+] ONNX export successful: {onnx_path} ({os.path.getsize(onnx_path)/(1024*1024):.2f} MB)")
