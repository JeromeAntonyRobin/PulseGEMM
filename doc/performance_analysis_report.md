# GEMM CNN Hardware Accelerator Performance & Scaling Analysis

## Executive Summary
This document details the performance analysis, scaling behavior, and architectural timing breakdown of the GEMM hardware accelerator deployed on the PolarFire SoC FPGA. 

Through an extensive empirical scaling sweep ranging from $16 \times 16 \times 16$ up to $256 \times 1152 \times 256$ GEMM workloads, we demonstrate that accelerator speedup exhibits a clear two-regime transition: from cache-assisted CPU execution on small matrices to steady-state compute convergence on large matrices.

---

## 1. Two-Regime Performance Scaling

The empirical speedup sweep across matrix dimensions reveals two distinct operational regimes:

| Matrix Size ($M \times K \times N$) | MAC Operations | SW CPU Time ($\mu$s) | HW System Time ($\mu$s) | Observed Speedup |
| :--- | :--- | :--- | :--- | :--- |
| **$16 \times 16 \times 16$** | 4,096 | 71.0 | 10.0 | **7.10x** |
| **$16 \times 32 \times 16$** | 8,192 | 132.0 | 14.0 | **9.43x** |
| **$32 \times 64 \times 32$** | 65,536 | 1,016.0 | 89.0 | **11.42x** |
| **$64 \times 128 \times 64$** | 524,288 | 8,202.1 | 623.0 | **13.17x** |
| **$128 \times 256 \times 128$** | 4,194,304 | 68,994.1 | 4,733.1 | **14.58x** |
| **$128 \times 576 \times 256$** | 18,874,368 | 1,023,266.2 | 20,815.3 | **49.16x** |
| **$256 \times 512 \times 256$** | 33,554,432 | 1,811,019.7 | 37,429.6 | **48.38x** |
| **$256 \times 1152 \times 256$** | 75,497,472 | 4,115,666.2 | 83,521.3 | **49.28x** |

### Regime 1: Cache-Friendly Domain (Small Matrices)
* **Behavior:** For small matrices ($M, K, N \le 128$), working sets fit efficiently within CPU L1/L2 cache structures.
* **Impact:** The CPU benefits disproportionately from high cache locality. Concurrently, fixed accelerator dispatch overheads represent a non-trivial fraction of total execution time.
* **Speedup Progression:** $7.10\times \rightarrow 9.43\times \rightarrow 11.42\times \rightarrow 14.58\times$.

### Regime 2: Steady-State Domain (Large Matrices)
* **Behavior:** For large matrices ($M, K, N > 128$), working sets significantly exceed CPU cache capacities.
* **Impact:** The measured software implementation enters a cache-limited regime exhibiting an approximately constant average cycle cost per MAC. Simultaneously, accelerator execution overheads become negligible relative to total compute.
* **Speedup Plateau:** $49.16\times \rightarrow 48.38\times \rightarrow 49.28\times$.

> [!IMPORTANT]
> **Formal Technical Conclusion:**
> For small GEMMs, CPU cache locality and fixed accelerator overhead reduce the observed speedup. As matrix dimensions increase beyond the cache-friendly regime, both implementations approach steady-state throughput, causing the measured acceleration to converge toward approximately **49x** for this workload and system configuration.

---

## 2. Hardware System Timing Model

Rather than assuming an ideal compute-throughput model ($\frac{MKN}{256}$ cycles), the true hardware execution time is modeled as:

$$T_{HW} = T_{\text{A-fetch}} + T_{\text{B-fetch}} + T_{\text{compute}} + T_{\text{store}} + T_{\text{overhead}} - T_{\text{overlap}}$$

Where $T_{\text{overlap}}$ represents the hardware cycles saved via parallel ping-pong execution between DMA memory fetching and systolic array computation.

### Architectural Breakdown:
1. **Matrix A (Weights):** Bursted via AXI ($a\_burst\_ok = \text{TRUE}$) due to software pre-packing into contiguous $16 \times 16$ tile order.
2. **Matrix B (Activations):** Currently fetched via row-by-row requests ($b\_burst\_ok = \text{FALSE}$) due to standard 2D layout strides ($stride\_b = N$).
3. **Systolic Core:** $16 \times 16$ processing element (PE) array running at 100 MHz.

---

## 3. Next Optimization Milestone: Block-Interleaved Matrix B

To eliminate the remaining memory fetch latency in $T_{\text{B-fetch}}$, the next scheduled engineering optimization involves:
1. **Software `im2col_block_interleaved`**: Reshaping activation maps into $16 \times 16$ block-interleaved contiguous memory during matrix unrolling.
2. **RTL Update (`gemm_dma_top.v`)**: Updating $b\_burst\_ok$ to match $stride\_b == 16$, enabling single-burst AXI reads for Matrix B.
