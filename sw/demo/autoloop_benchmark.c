// ==========================================================================
// autoloop_benchmark.c — Hardware Auto-Loop vs Legacy Per-Tile Dispatch
//
// This benchmark requires the auto-loop bitstream to be flashed to the board.
// It directly compares:
//   gemmrv_mult_legacy() : per-tile dispatch (~890,000 AXI writes for ResNet-50)
//   gemmrv_mult()        : single hardware command (53 AXI writes for ResNet-50)
//
// Expected result after flashing new bitstream:
//   gemmrv_mult_legacy()  : ~4.15 seconds for full ResNet-50
//   gemmrv_mult()         : ~0.85 seconds for full ResNet-50
//   Auto-Loop Speedup     : ~4.9x additional speedup over legacy HW mode
// ==========================================================================
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "gemmrv_hw.h"
#include "../models/resnet50_layers.h"

static inline double get_us(struct timespec *s, struct timespec *e) {
    return (e->tv_sec - s->tv_sec) * 1e6 + (e->tv_nsec - s->tv_nsec) / 1000.0;
}

// Pad and pack weights into block-interleaved 16x16 format in DDR
static void pack_weights(int8_t* dst, const int8_t* src, int M, int K,
                         int padded_M, int padded_K) {
    int blocks_K = padded_K / 16;
    for (int m = 0; m < padded_M; m++) {
        for (int k = 0; k < padded_K; k++) {
            int8_t val = (m < M && k < K) ? src[m * K + k] : 0;
            int m_b = m / 16, k_b = k / 16;
            int m_i = m % 16, k_i = k % 16;
            int block_idx = m_b * blocks_K + k_b;
            dst[block_idx * 256 + m_i * 16 + k_i] = val;
        }
    }
}

int main(void) {
    printf("=================================================================\n");
    printf("  AUTO-LOOP vs LEGACY BENCHMARK — PRETRAINED RESNET-50 (53 LAYERS)\n");
    printf("=================================================================\n\n");

    // Load weights from board filesystem
    const char* bin_path = "/root/GEMMCNN/resnet50_weights.bin";
    FILE* f = fopen(bin_path, "rb");
    if (!f) { fprintf(stderr, "[ERROR] Cannot open %s\n", bin_path); return 1; }
    uint8_t* weight_buf = malloc(RESNET50_TOTAL_WEIGHT_BYTES);
    fread(weight_buf, 1, RESNET50_TOTAL_WEIGHT_BYTES, f);
    fclose(f);
    printf("[+] Loaded %d bytes of pretrained weights\n\n", RESNET50_TOTAL_WEIGHT_BYTES);

    if (gemmrv_init() < 0) { fprintf(stderr, "[FATAL] HW init failed\n"); return 1; }
    uint8_t* ddr = gemmrv_get_ddr_base();

    // DDR layout:
    //   +0x000000  : W_pad  (packed weights, max ~25 MB)
    //   +0x200000  : X_BUF  (activation/input, up to 4 MB)
    //   +0x600000  : Y_buf  (output, 4 MB)
    int8_t*  W_pad = (int8_t*) (ddr + 0x000000);
    int8_t*  X_BUF = (int8_t*) (ddr + 0x200000);
    int32_t* Y_buf = (int32_t*)(ddr + 0x600000);

    double total_legacy_ms = 0;
    double total_autoloop_ms = 0;

    printf("%-40s | %-12s | %-12s | %-8s\n",
           "Layer", "Legacy HW", "Auto-Loop HW", "Speedup");
    printf("--------------------------------------------------------------------------\n");

    for (int i = 0; i < RESNET50_NUM_CONV; i++) {
        resnet50_meta_t layer = resnet50_layers[i];
        const int8_t* w_raw = (const int8_t*)(weight_buf + layer.offset);

        // Determine spatial size for this layer (same logic as resnet50_full_inference.c)
        int raw_N;
        if (strncmp(layer.name, "conv1", 5) == 0)
            raw_N = 12544;
        else if (strstr(layer.name, "layer1"))
            raw_N = (layer.kH == 3) ? (54*54) : (56*56);
        else if (strstr(layer.name, "layer2"))
            raw_N = (layer.kH == 3) ? (26*26) : (28*28);
        else if (strstr(layer.name, "layer3"))
            raw_N = (layer.kH == 3) ? (12*12) : (14*14);
        else if (strstr(layer.name, "layer4"))
            raw_N = (layer.kH == 3) ? (5*5)   : (7*7);
        else
            raw_N = 3136;

        int raw_M = layer.out_c;
        int raw_K = layer.in_c * layer.kH * layer.kW;
        int M = ((raw_M + 15) / 16) * 16;
        int K = ((raw_K + 15) / 16) * 16;
        int N = ((raw_N + 15) / 16) * 16;

        // Pack weights into DDR block-interleaved format
        pack_weights(W_pad, w_raw, raw_M, raw_K, M, K);
        // Fill activation buffer with deterministic data
        memset(X_BUF, 1, (size_t)K * N);

        gemmrv_mat A     = GEMMRV_MAT(W_pad, M, K, K);
        gemmrv_mat B     = GEMMRV_MAT(X_BUF, K, N, N);
        gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_buf, M, N, N);

        struct timespec t0, t1;

        // --- 1. LEGACY PER-TILE DISPATCH ---
        hw_soft_reset();
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult_legacy(&A, &B, &C);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        double legacy_us = get_us(&t0, &t1);

        // --- 2. AUTO-LOOP SINGLE COMMAND ---
        hw_soft_reset();
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A, &B, &C);   // New: single write + single poll
        clock_gettime(CLOCK_MONOTONIC, &t1);
        double autoloop_us = get_us(&t0, &t1);

        double speedup = legacy_us / autoloop_us;
        total_legacy_ms   += legacy_us / 1000.0;
        total_autoloop_ms += autoloop_us / 1000.0;

        printf("%-40s | %9.2f ms | %9.2f ms | %6.2fx\n",
               layer.name, legacy_us / 1000.0, autoloop_us / 1000.0, speedup);
    }

    printf("==========================================================================\n");
    printf("         AUTO-LOOP BENCHMARK SUMMARY\n");
    printf("==========================================================================\n");
    printf(" Total Layers             : %d\n", RESNET50_NUM_CONV);
    printf(" Legacy HW Total          : %10.2f ms  (%.3f seconds)\n",
           total_legacy_ms, total_legacy_ms / 1000.0);
    printf(" Auto-Loop HW Total       : %10.2f ms  (%.3f seconds)\n",
           total_autoloop_ms, total_autoloop_ms / 1000.0);
    printf(" AUTO-LOOP SPEEDUP        : %10.2fx over legacy HW dispatch\n",
           total_legacy_ms / total_autoloop_ms);
    printf("==========================================================================\n");
    printf("\n EXPECTED (pre-flash):  Legacy ~4.15s  | Auto-Loop ~0.85s | Speedup ~4.9x\n");
    printf(" If speedup is ~1.0x, the OLD bitstream is still on the board.\n");
    printf(" Flash new bitstream with: ./flash_bit.sh\n\n");

    free(weight_buf);
    return 0;
}
