#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "gemmrv_hw.h"

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
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

void im2col(const int8_t* image, int8_t* X, int in_c, int in_h, int in_w, int k, int padded_K, int padded_N) {
    int out_h = in_h - k + 1;
    int out_w = in_w - k + 1;
    memset(X, 0, padded_K * padded_N);
    int row = 0;
    for(int c=0; c<in_c; c++) {
        for(int kh=0; kh<k; kh++) {
            for(int kw=0; kw<k; kw++) {
                int col = 0;
                for(int oh=0; oh<out_h; oh++) {
                    const int8_t* img_ptr = &image[c*(in_h*in_w) + (oh+kh)*in_w + kw];
                    int8_t* out_ptr = &X[row * padded_N + col];
                    memcpy(out_ptr, img_ptr, out_w);
                    col += out_w;
                }
                row++;
            }
        }
    }
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

void apply_bias_relu_scale(const int32_t* Y, int8_t* out_fmap, const int32_t* bias, int actual_M, int actual_N, int padded_N, int shift_bits) {
    for(int m=0; m<actual_M; m++) {
        int32_t b = bias[m];
        for(int n=0; n<actual_N; n++) {
            int32_t val = Y[m*padded_N + n] + b;
            if(val < 0) val = 0; // ReLU
            val = val >> shift_bits;
            if(val > 127) val = 127;
            out_fmap[m*actual_N + n] = (int8_t)val;
        }
    }
}

typedef struct {
    double im2col_us;
    double gemm_us;
    double relu_bias_us;
    double total_us;
} stats_t;

void run_model_layer(const char* name, int M, int K, int N, int in_c, int in_h, int in_w, int k_size) {
    uint8_t* ddr_work = gemmrv_get_ddr_base();
    
    int8_t* W_src = malloc(M * K);
    int32_t* bias = malloc(M * sizeof(int32_t));
    int8_t* W_pad = (int8_t*)(ddr_work + 0x000000);
    int8_t* IMAGE = (int8_t*)(ddr_work + 0x100000);
    int8_t* X_UNR = (int8_t*)(ddr_work + 0x200000);
    int32_t* Y_HW = (int32_t*)(ddr_work + 0x400000);
    int8_t* OUT_HW = (int8_t*)(ddr_work + 0x500000);
    
    int32_t* Y_SW = malloc(M * N * sizeof(int32_t));
    int8_t* OUT_SW = malloc(M * N);
    
    for(int i=0; i<M*K; i++) W_src[i] = (i%21)-10;
    for(int i=0; i<in_c*in_h*in_w; i++) IMAGE[i] = (i%13)-6;
    for(int i=0; i<M; i++) bias[i] = (i%5)-2;
    
    pad_and_copy_weights(W_pad, W_src, M, K, M, K);
    
    gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
    gemmrv_mat B = GEMMRV_MAT(X_UNR, K, N, N);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_HW, M, N, N);
    
    struct timespec start_tot, end_tot, t0, t1;
    stats_t sw_stats = {0}, hw_stats = {0};
    
    clock_gettime(CLOCK_MONOTONIC, &start_tot);
    clock_gettime(CLOCK_MONOTONIC, &t0);
    im2col(IMAGE, X_UNR, in_c, in_h, in_w, k_size, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    sw_stats.im2col_us = get_time_us(&t0, &t1);
    
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemm_sw(W_src, X_UNR, Y_SW, M, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    sw_stats.gemm_us = get_time_us(&t0, &t1);
    
    clock_gettime(CLOCK_MONOTONIC, &t0);
    apply_bias_relu_scale(Y_SW, OUT_SW, bias, M, N, N, 2);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    sw_stats.relu_bias_us = get_time_us(&t0, &t1);
    clock_gettime(CLOCK_MONOTONIC, &end_tot);
    sw_stats.total_us = get_time_us(&start_tot, &end_tot);

    clock_gettime(CLOCK_MONOTONIC, &start_tot);
    clock_gettime(CLOCK_MONOTONIC, &t0);
    im2col(IMAGE, X_UNR, in_c, in_h, in_w, k_size, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    hw_stats.im2col_us = get_time_us(&t0, &t1);
    
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    hw_stats.gemm_us = get_time_us(&t0, &t1);
    
    clock_gettime(CLOCK_MONOTONIC, &t0);
    apply_bias_relu_scale(Y_HW, OUT_HW, bias, M, N, N, 2);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    hw_stats.relu_bias_us = get_time_us(&t0, &t1);
    clock_gettime(CLOCK_MONOTONIC, &end_tot);
    hw_stats.total_us = get_time_us(&start_tot, &end_tot);
    
    int errors = 0;
    int max_diff = 0;
    for(int i=0; i<M*N; i++) {
        int diff = abs(OUT_SW[i] - OUT_HW[i]);
        if(diff > max_diff) max_diff = diff;
        if(diff > 0) errors++;
    }

    printf("\n============================================================\n");
    printf("   %s Inference\n", name);
    printf("============================================================\n");
    printf("[*] Running Pure Software Baseline Inference...\n");
    printf("[*] Running 2D Strided Zero-Copy HW Inference...\n");
    printf("\n-------------------- INFERENCE RESULTS --------------------\n");
    printf("Layer Configuration   : M=%d, K=%d, N=%d (Kernel: %dx%d)\n", M, K, N, k_size, k_size);
    printf("Verification          : %s (Max logit diff: %d)\n", (errors==0?"SUCCESS / MATCH":"FAILED"), max_diff);
    printf("\n------------------- TIMING BREAKDOWN (us) -------------------\n");
    printf("%-20s | %-12s | %-12s | %-10s\n", "Phase", "SW (CPU)", "HW System", "Speedup");
    printf("-------------------------------------------------------------\n");
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "im2col transform", sw_stats.im2col_us, hw_stats.im2col_us, sw_stats.im2col_us / hw_stats.im2col_us);
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "GEMM Convolutions", sw_stats.gemm_us, hw_stats.gemm_us, sw_stats.gemm_us / hw_stats.gemm_us);
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "ReLU & Bias", sw_stats.relu_bias_us, hw_stats.relu_bias_us, sw_stats.relu_bias_us / hw_stats.relu_bias_us);
    printf("-------------------------------------------------------------\n");
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "TOTAL END-TO-END", sw_stats.total_us, hw_stats.total_us, sw_stats.total_us / hw_stats.total_us);
    printf("=============================================================\n");

    free(W_src);
    free(bias);
    free(Y_SW);
    free(OUT_SW);
}

int main() {
    if (gemmrv_init() < 0) return 1;
    run_model_layer("VGG-16 Conv3_1 Layer", 256, 1152, 256, 128, 18, 18, 3);
    run_model_layer("ResNet-50 Conv4_1 Layer", 256, 2304, 256, 256, 18, 18, 3);
    return 0;
}
