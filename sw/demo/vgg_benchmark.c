#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "gemmrv_hw.h"

// Re-use the optimized pad_and_copy_weights
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

int main() {
    printf("\n============================================================\n");
    printf("   Large CNN Layer Benchmark (VGG/ResNet Scale)\n");
    printf("============================================================\n");

    if (gemmrv_init() < 0) {
        printf("Failed to init GEMMrv HW\n");
        return 1;
    }
    uint8_t* ddr_work = gemmrv_get_ddr_base();
    
    // Test 1: VGG-like Conv Layer (M=128, K=576, N=1024)
    // Needs pad multiple of 16 -> M=128, K=576, N=1024 are all already mults of 16!
    int M = 128;
    int K = 576;
    int N = 1024;
    
    printf("[*] Generating random weights and activations (M=%d, K=%d, N=%d)...\n", M, K, N);
    int8_t* W_src = malloc(M * K);
    int8_t* X_src = (int8_t*)(ddr_work + 0x000000); // 576*1024 = ~589 KB
    int32_t* Y_hw = (int32_t*)(ddr_work + 0x100000); // 128*1024*4 = 524 KB
    int8_t* W_pad = (int8_t*)(ddr_work + 0x200000); // 128*576 = 73 KB
    int32_t* Y_sw = malloc(M * N * sizeof(int32_t));
    
    for(int i=0; i<M*K; i++) W_src[i] = (int8_t)((i%21)-10);
    for(int i=0; i<K*N; i++) X_src[i] = (int8_t)((i%13)-6);
    
    printf("[*] Pre-packing weights into Block-Interleaved layout...\n");
    pad_and_copy_weights(W_pad, W_src, M, K, M, K);
    
    gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
    gemmrv_mat B = GEMMRV_MAT(X_src, K, N, N);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_hw, M, N, N);
    
    struct timespec t0, t1;
    
    printf("[*] Running Software Baseline (CPU)...\n");
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemm_sw(W_src, X_src, Y_sw, M, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double sw_us = get_time_us(&t0, &t1);
    
    printf("[*] Running Hardware Accelerator...\n");
    hw_reset_perf_counters();
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double hw_us = get_time_us(&t0, &t1);
    
    // Verify
    int errors = 0;
    int max_diff = 0;
    for(int i=0; i<M*N; i++) {
        int diff = abs(Y_sw[i] - Y_hw[i]);
        if(diff > 0) errors++;
        if(diff > max_diff) max_diff = diff;
    }
    
    uint32_t perf[4];
    hw_read_perf_breakdown(perf);
    uint32_t total_cycles = perf[0] + perf[1] + perf[2] + perf[3];
    double ip_us = total_cycles / 100.0;
    
    printf("\n-------------------- BENCHMARK RESULTS --------------------\n");
    printf("Verification      : %s (Errors: %d, Max Diff: %d)\n", (errors == 0 ? "SUCCESS" : "FAILED"), errors, max_diff);
    printf("SW Compute Time   : %.1f us\n", sw_us);
    printf("HW System Time    : %.1f us\n", hw_us);
    printf("HW System Speedup : %.2fx\n", sw_us / hw_us);
    printf("\nHardware IP Internals:\n");
    printf("  Fetch A Cycles  : %u\n", perf[0]);
    printf("  Fetch B Cycles  : %u\n", perf[1]);
    printf("  Compute Cycles  : %u\n", perf[2]);
    printf("  Store C Cycles  : %u\n", perf[3]);
    printf("  Pure IP Time    : %.1f us\n", ip_us);
    printf("  Pure IP Speedup : %.2fx\n", sw_us / ip_us);
    printf("============================================================\n");

    free(W_src);
    free(Y_sw);
    return 0;
}
