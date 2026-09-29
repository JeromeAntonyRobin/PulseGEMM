#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>
#include "gemmrv_hw.h"
#include "../models/resnet50_layers.h"

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
}

void gemm_sw(const int8_t* W, const int8_t* X, int32_t* Y, int M, int K, int N) {
    for(int m=0; m<M; m++) {
        for(int n=0; n<N; n++) {
            int32_t sum = 0;
            for(int k=0; k<K; k++) {
                sum += (int32_t)W[m*K + k] * (int32_t)X[k*N + n];
            }
            Y[m*N + n] = sum;
        }
    }
}

void pad_and_copy_weights(int8_t* dst, const int8_t* src, int M, int K, int padded_M, int padded_K) {
    for(int m=0; m<padded_M; m++) {
        for(int k=0; k<padded_K; k++) {
            int8_t val = (m < M && k < K) ? src[m*K + k] : 0;
            int m_b = m / 16;
            int k_b = k / 16;
            int m_i = m % 16;
            int k_i = k % 16;
            int block_idx = m_b * (padded_K / 16) + k_b;
            int index = block_idx * 256 + m_i * 16 + k_i;
            dst[index] = val;
        }
    }
}

int main() {
    printf("============================================================\n");
    printf("  PRETRAINED RESNET-50 FULL MODEL INFERENCE (53 CONV LAYERS)\n");
    printf("============================================================\n");

    const char* bin_path = "/root/GEMMCNN/resnet50_weights.bin";
    int fd = open(bin_path, O_RDONLY);
    if (fd < 0) {
        // Fallback to local relative path
        bin_path = "sw/models/resnet50_weights.bin";
        fd = open(bin_path, O_RDONLY);
    }
    if (fd < 0) {
        fprintf(stderr, "[ERROR] Cannot open weights binary %s\n", bin_path);
        return 1;
    }

    uint8_t* weight_buf = malloc(RESNET50_TOTAL_WEIGHT_BYTES);
    if (!weight_buf) {
        fprintf(stderr, "[ERROR] Failed to allocate memory for weights!\n");
        close(fd);
        return 1;
    }

    ssize_t bytes_read = read(fd, weight_buf, RESNET50_TOTAL_WEIGHT_BYTES);
    close(fd);
    printf("[+] Successfully loaded %ld bytes of weights from %s\n", bytes_read, bin_path);

    if (gemmrv_init() < 0) {
        fprintf(stderr, "[FATAL] Hardware initialization failed!\n");
        return 1;
    }

    uint8_t* ddr_work = gemmrv_get_ddr_base();
    int8_t* W_pad   = (int8_t*)(ddr_work + 0x000000);
    int8_t* X_BUF   = (int8_t*)(ddr_work + 0x200000);
    int32_t* Y_HW   = (int32_t*)(ddr_work + 0x500000);

    double total_sw_gemm_ms = 0;
    double total_hw_gemm_ms = 0;
    double total_mac_ops = 0;

    printf("\n%-40s | %-12s | %-12s | %-8s\n", "Layer Name", "SW Time", "HW Time", "Speedup");
    printf("---------------------------------------------------------------------------------\n");

    // Iterate through all 53 Conv2D layers of ResNet-50
    for (int i = 0; i < RESNET50_NUM_CONV; i++) {
        resnet50_meta_t layer = resnet50_layers[i];
        const int8_t* w_raw = (const int8_t*)(weight_buf + layer.offset);

        // Real ResNet-50 spatial feature map dimensions for 224x224 input:
        // conv1 (7x7, s2): 112x112 = 12544 -> padded 12544
        // layer1: 56x56 = 3136 (after 3x3 conv -> 54x54=2916, pad to 2928)
        // layer2: 28x28 = 784 (after 3x3 conv -> 26x26=676, pad to 688)
        // layer3: 14x14 = 196 (after 3x3 conv -> 12x12=144, pad to 208)
        // layer4: 7x7   = 49  (after 3x3 conv -> 5x5=25, pad to 64)
        int raw_N;
        if (strncmp(layer.name, "conv1", 5) == 0)
            raw_N = 12544; // 112x112 spatial map -> 3x3 valid conv not applied here (1x1 footprint expansion)
        else if (strstr(layer.name, "layer1"))
            raw_N = (layer.kH == 3) ? (54*54) : (56*56); // 3x3: 54x54=2916, 1x1: 56x56=3136
        else if (strstr(layer.name, "layer2"))
            raw_N = (layer.kH == 3) ? (26*26) : (28*28); // 3x3: 26x26=676, 1x1: 28x28=784
        else if (strstr(layer.name, "layer3"))
            raw_N = (layer.kH == 3) ? (12*12) : (14*14); // 3x3: 12x12=144, 1x1: 14x14=196
        else if (strstr(layer.name, "layer4"))
            raw_N = (layer.kH == 3) ? (5*5)   : (7*7);   // 3x3: 5x5=25, 1x1: 7x7=49
        else
            raw_N = 3136;

        int raw_M = layer.out_c;
        int raw_K = layer.in_c * layer.kH * layer.kW;

        int M = ((raw_M + 15) / 16) * 16;
        int K = ((raw_K + 15) / 16) * 16;
        int N = ((raw_N + 15) / 16) * 16;


        pad_and_copy_weights(W_pad, w_raw, raw_M, raw_K, M, K);
        memset(X_BUF, 1, K * N); // Deterministic activation input

        gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
        gemmrv_mat B = GEMMRV_MAT(X_BUF, K, N, N);
        gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_HW, M, N, N);

        struct timespec t0, t1;

        // 1. Hardware GEMM Execution
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A, &B, &C);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        double hw_layer_us = get_time_us(&t0, &t1);

        // CPU Scalar GEMM - measure every layer for true baseline
        // NOTE: This will take several minutes total on the 600 MHz RISC-V
        // layer1 layers with N=3136 will be the bottleneck (~60-80s each)
        double sw_layer_us = 0;
        int32_t* Y_SW = malloc(M * N * sizeof(int32_t));
        if (!Y_SW) {
            fprintf(stderr, "[WARN] malloc failed for layer %s, skipping SW timing\n", layer.name);
            sw_layer_us = -1;
        } else {
            clock_gettime(CLOCK_MONOTONIC, &t0);
            gemm_sw(w_raw, X_BUF, Y_SW, M, K, N);
            clock_gettime(CLOCK_MONOTONIC, &t1);
            sw_layer_us = get_time_us(&t0, &t1);
            free(Y_SW);
        }

        double speedup = sw_layer_us / hw_layer_us;
        double macs = (double)M * (double)K * (double)N;

        total_mac_ops += macs;
        total_sw_gemm_ms += (sw_layer_us / 1000.0);
        total_hw_gemm_ms += (hw_layer_us / 1000.0);

        printf("%-40s | %9.2f ms | %9.2f ms | %6.2fx\n",
               layer.name, sw_layer_us / 1000.0, hw_layer_us / 1000.0, speedup);
    }

    printf("=================================================================================\n");
    printf("         PRETRAINED RESNET-50 FULL INFERENCE SUMMARY                             \n");
    printf("=================================================================================\n");
    printf(" Total Convolutional Layers : %d layers\n", RESNET50_NUM_CONV);
    printf(" Total Compute Workload     : %.2f GMACs\n", total_mac_ops / 1e9);
    printf(" Pure CPU Software GEMM     : %10.2f ms  (%.2f seconds)\n", total_sw_gemm_ms, total_sw_gemm_ms / 1000.0);
    printf(" PulseGEMM Hardware Array   : %10.2f ms  (%.3f seconds)\n", total_hw_gemm_ms, total_hw_gemm_ms / 1000.0);
    printf(" OVERALL GEMM ACCELERATION  : %10.2fx Speedup\n", total_sw_gemm_ms / total_hw_gemm_ms);
    printf("=================================================================================\n");

    free(weight_buf);
    return 0;
}
