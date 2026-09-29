import torch
import torchvision.models as models
import numpy as np
import os
import struct

os.makedirs("sw/models", exist_ok=True)
BIN_FILE = "sw/models/resnet50_weights.bin"
META_FILE = "sw/models/resnet50_layers.h"

print("[*] Loading pretrained ResNet-50...")
model = models.resnet50(weights=models.ResNet50_Weights.IMAGENET1K_V1)
model.eval()

layers = {}
for name, param in model.state_dict().items():
    layers[name] = param

conv_layers = {k: v for k, v in layers.items() if 'weight' in k and len(v.shape) == 4}

offset = 0
meta_entries = []

with open(BIN_FILE, "wb") as f_bin:
    for lname, wt in conv_layers.items():
        t_np = wt.detach().float().numpy()
        amax = np.abs(t_np).max()
        scale = amax / 127.0 if amax > 0 else 1.0
        q = np.clip(np.round(t_np / scale), -128, 127).astype(np.int8)
        
        out_c, in_c, kH, kW = q.shape
        data_bytes = q.tobytes()
        f_bin.write(data_bytes)
        
        meta_entries.append({
            'name': lname,
            'out_c': out_c,
            'in_c': in_c,
            'kH': kH,
            'kW': kW,
            'offset': offset,
            'size': len(data_bytes),
            'scale': scale
        })
        offset += len(data_bytes)

with open(META_FILE, "w") as f_h:
    f_h.write("// Auto-generated layer metadata for ResNet-50\n")
    f_h.write("#pragma once\n#include <stdint.h>\n\n")
    f_h.write(f"#define RESNET50_TOTAL_WEIGHT_BYTES {offset}\n")
    f_h.write(f"#define RESNET50_NUM_CONV {len(meta_entries)}\n\n")
    f_h.write("typedef struct {\n")
    f_h.write("    const char* name;\n")
    f_h.write("    int out_c, in_c, kH, kW;\n")
    f_h.write("    uint32_t offset;\n")
    f_h.write("    uint32_t size;\n")
    f_h.write("    float scale;\n")
    f_h.write("} resnet50_meta_t;\n\n")
    f_h.write("static const resnet50_meta_t resnet50_layers[RESNET50_NUM_CONV] = {\n")
    for m in meta_entries:
        f_h.write(f'    {{"{m["name"]}", {m["out_c"]}, {m["in_c"]}, {m["kH"]}, {m["kW"]}, {m["offset"]}, {m["size"]}, {m["scale"]:.8f}f}},\n')
    f_h.write("};\n")

print(f"[+] Successfully exported {BIN_FILE} ({offset / (1024*1024):.2f} MB)")
print(f"[+] Successfully generated {META_FILE}")
