# GEMM CNN Hardware Accelerator

A high-performance, 2D-strided zero-copy hardware accelerator for Convolutional Neural Network (CNN) workloads, designed for the Microchip PolarFire SoC FPGA. Featuring a $16 \times 16$ processing-element (PE) systolic array core and an integrated AXI4 DMA engine with ping-pong buffering, the accelerator achieves up to **~49.3x speedup** over CPU software execution on large-scale matrix operations.

---

## Key Features

- **Systolic Array Core:** $16 \times 16$ grid of 8-bit integer processing elements executing 256 Multiply-Accumulate (MAC) operations per clock cycle.
- **AXI4 DMA Engine with Ping-Pong Buffering:** Overlaps memory fetching with compute execution to minimize memory stall latency.
- **2D Strided Memory Addressing:** Hardware support for 2D strided address generation, enabling zero-copy matrix extraction directly from multi-dimensional activation maps.
- **AXI4 Burst-Mode Optimization:** High-throughput burst DMA transactions for contiguous block-interleaved matrix layouts.
- **Software Driver:** Lightweight C abstraction layer (`gemmrv_hw`) providing memory mapping, weight pre-packing utilities, and multi-tile matrix multiplication functions.

---

## Repository Structure

```text
GEMMCNN/
├── rtl/
│   ├── gemm/           # Decoupled GEMM Accelerator IP
│   │   ├── gemm_dma_top.v          # Top-level AXI4 DMA controller & FSM
│   │   ├── gemm_systolic_core.v   # 16x16 PE array wrapper & skew buffers
│   │   ├── gemm_pe.v              # Processing element multiply-accumulate unit
│   │   ├── gemm_skew_buffer.v     # Systolic timing skew delay registers
│   │   ├── gemm_top.v             # GEMM top module wrapper
│   │   └── gemm_axi_slave.v       # AXI4-Lite slave configuration register map
│   ├── wrappers/       # Bus interconnect & peripheral wrappers
│   │   └── FIC_0_PERIPHERALS.v    # PolarFire FIC_0 AXI interconnect wrapper
│   └── assets/         # PolarFire SoC vendor IP blocks and MSS components
├── tb/                 # SystemVerilog testbenches & simulation stimulus
│   └── tb_gemm_dma.sv
├── sw/
│   ├── lib/            # Hardware abstraction driver & register map
│   │   ├── gemmrv_hw.c            # Driver implementation & tile management
│   │   └── gemmrv_hw.h            # Memory map & C API declarations
│   └── demo/           # Benchmark suites & neural network inference demos
│       ├── demo_lenet.c           # Full LeNet-5 end-to-end inference demo
│       ├── benchmark_models.c     # VGG-16 & ResNet-50 layer benchmarks
│       ├── test_integrity.c       # Comprehensive data accuracy test suite
│       └── compiled/              # Target RISC-V cross-compiled binaries
├── tcl/                # Synthesis, PnR, and IO constraint scripts
│   ├── const.tcl                  # Pinout & bank IO constraints
│   └── run_pnr.tcl                # Libero SoC batch synthesis & PnR script
├── bitstream/          # Synthesized FPGA programming files (.pdb / .job)
│   └── gemm_top.pdb
├── doc/                # Architectural analysis reports & synthesis logs
│   ├── performance_analysis_report.md
│   └── synthesis_logs/
├── flash_bit.sh        # Root automation: Program bitstream to FPGA board
├── run_pnr.sh          # Root automation: Launch Libero batch synthesis & PnR
└── run_script.sh       # Root automation: Cross-compile C code & run on board
```

---

## RTL Architecture

The accelerator is divided into three core hardware layers:

```
                  +-------------------------------------------------+
                  |                AXI4 System Bus                  |
                  +-----------------------+-------------------------+
                                          |
                                    AXI4 Master (64-bit)
                                          |
                  +-----------------------v-------------------------+
                  |                 gemm_dma_top                    |
                  |  +-------------------+   +-------------------+  |
                  |  |  DMA Engine FSM   |   | Ping-Pong Buffers |  |
                  |  +---------+---------+   +---------+---------+  |
                  +------------|-----------------------|------------+
                               |                       |
                          Control Signal             Data
                               |                       |
                  +------------v-----------------------v------------+
                  |               gemm_systolic_core                |
                  |  +-------------------+   +-------------------+  |
                  |  |   Skew Buffers    |   | 16x16 PE Array    |  |
                  |  +-------------------+   +-------------------+  |
                  +-------------------------------------------------+
```

### 1. `gemm_dma_top.v`
Top-level DMA controller managing AXI4 master memory transactions and AXI4-Lite configuration access. Key features:
- **Ping-Pong Buffer Coordination:** Double-buffered SRAM tiles (`buf_a_ping`/`pong`, `buf_b_ping`/`pong`) ensure the DMA engine fetches tile $N+1$ while the systolic array computes tile $N$.
- **AXI4 Master Engine:** 64-bit wide read/write interfaces. Converts 2D strided requests into sequential AXI burst transactions (`a_burst_ok`).

### 2. `gemm_systolic_core.v`
Wraps the processing element array with input data delay buffers (`gemm_skew_buffer.v`) to align data arrival across row and column channels for wave-front systolic processing.

### 3. `gemm_pe.v`
The fundamental compute element containing an 8-bit signed multiplier and a 32-bit accumulator register:
$$\text{Acc}_{t+1} = \text{Acc}_t + (A_{\text{in}} \times B_{\text{in}})$$

---

## Software Driver & API (`sw/lib`)

The hardware is managed via the `gemmrv_hw` C driver, which abstracts low-level register writes and physical memory mapping (`/dev/mem`).

### Memory Register Map
| Register Name | Offset | Type | Description |
| :--- | :--- | :--- | :--- |
| `REG_CTRL` | `0x00` | R/W | Bit 0: Start, Bit 1: Clear Acc, Bit 2: Store C, Bit 4: Soft Reset |
| `REG_STATUS` | `0x04` | Read | Bit 0: Busy, Bit 1: Err, Bit 2: Done |
| `REG_SRC_A` | `0x08` | R/W | Physical base address of Matrix A (Weights) |
| `REG_SRC_B` | `0x0C` | R/W | Physical base address of Matrix B (Activations) |
| `REG_DST_C` | `0x10` | R/W | Physical base address of Matrix C (Outputs) |
| `REG_STRIDE_A` | `0x14` | R/W | Stride A in bytes |
| `REG_STRIDE_B` | `0x18` | R/W | Stride B in bytes |
| `REG_STRIDE_C` | `0x1C` | R/W | Stride C in 32-bit elements |
| `REG_BOUNDS` | `0x20` | R/W | Packed dimensions: `[28:24]` Tile N, `[20:16]` Tile M, `[15:0]` K total |

### C Driver Usage

```c
#include "gemmrv_hw.h"

int main() {
    // 1. Initialize driver & map physical DDR space
    if (gemmrv_init() < 0) return -1;
    
    // 2. Define Matrix Descriptors
    gemmrv_mat A = GEMMRV_MAT(weight_buf, M, K, stride_A);
    gemmrv_mat B = GEMMRV_MAT(input_buf, K, N, stride_B);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(output_buf, M, N, stride_C);
    
    // 3. Execute Hardware Accelerated Matrix Multiplication
    gemmrv_mult(&A, &B, &C);
    
    return 0;
}
```

---

## Automation Workflows

Root-level shell scripts streamline compilation, cross-deployment, FPGA synthesis, and bitstream programming.

### 1. Execute Application / Demo (`./run_script.sh`)
Cross-compiles a C application using the RISC-V toolchain, deploys the binary to the PolarFire SoC board via SCP, and streams the execution output live over SSH.

```bash
./run_script.sh sw/demo/demo_lenet.c
```
*Compiled binaries are automatically stored in `sw/demo/compiled/`.*

### 2. Synthesize & Place-and-Route (`./run_pnr.sh`)
Executes Libero SoC in batch mode using `tcl/run_pnr.tcl` to perform synthesis, Place-and-Route, and bitstream generation.

```bash
./run_pnr.sh
```

### 3. Flash Bitstream to FPGA (`./flash_bit.sh`)
Programs the generated bitstream (`bitstream/gemm_top.pdb`) onto the PolarFire SoC Discovery Kit using Microchip FPExpress.

```bash
./flash_bit.sh
```

---

## Performance Summary

Across extensive empirical benchmarks on the PolarFire SoC, the accelerator demonstrates a clear two-regime performance profile:

| Benchmark | Workload Configuration | CPU Baseline | HW Accelerator | Total Speedup |
| :--- | :--- | :--- | :--- | :--- |
| **LeNet-5 Full Inference** | Conv1, Conv2, FC layers | 13.01 ms | 3.37 ms | **3.88x E2E** |
| **VGG-16 Conv3_1 Layer** | $M=256, K=1152, N=256$ | 4.39 s | 0.089 s | **48.96x E2E** |
| **ResNet-50 Conv4_1 Layer** | $M=256, K=2304, N=256$ | 8.81 s | 0.179 s | **49.09x E2E** |

For detailed performance models and scaling analysis, see [doc/performance_analysis_report.md](/doc/performance_analysis_report.md).
