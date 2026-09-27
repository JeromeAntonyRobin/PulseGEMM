#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "gemm_lib/gemmrv_hw.h"
#include "lenet_weights.h"

// Memory buffers
static int8_t IMAGE_BUF[3 * 32 * 32] __attribute__((aligned(32)));
static int8_t X_UNROLLED[160 * 784] __attribute__((aligned(32))); // Buffer for unrolled im2col
static int32_t Y_BUF[32 * 784] __attribute__((aligned(32)));      // Output accumulation buffer
static int8_t FMAP_A[16 * 14 * 14] __attribute__((aligned(32)));   // Feature maps
static int8_t FMAP_B[16 * 14 * 14] __attribute__((aligned(32)));
static int8_t WEIGHT_PADDED[160 * 400] __attribute__((aligned(32)));

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
}

static const char* color_names[23] = {
    "dark-red",      // 0
    "white",         // 1
    "black",         // 2
    "orange",        // 3
    "silver-gray",   // 4
    "dark-blue",     // 5
    "grass-green",   // 6
    "red",           // 7
    "dark-gray",     // 8
    "gray",          // 9
    "brown",         // 10
    "cyan",          // 11
    "blue",          // 12
    "champagne",     // 13
    "dark-brown",    // 14
    "dark-orange",   // 15
    "pink",          // 16
    "lemon-yellow",  // 17
    "yellow",        // 18
    "earthy-yellow", // 19
    "red-orange",    // 20
    "green",         // 21
    "dark-green"     // 22
};

void pad_and_copy_weights(int8_t* dst, const int8_t* src, int M, int K, int padded_M, int padded_K) {
    for(int m=0; m<padded_M; m++) {
        for(int k=0; k<padded_K; k++) {
            if (m < M && k < K) {
                dst[m*padded_K + k] = src[m*K + k];
            } else {
                dst[m*padded_K + k] = 0;
            }
        }
    }
}

void im2col(const int8_t* image, int8_t* X, int in_c, int in_h, int in_w, int k, int padded_K, int padded_N) {
    int out_h = in_h - k + 1;
    int out_w = in_w - k + 1;
    int actual_N = out_h * out_w;
    int col = 0;
    for(int oh=0; oh<out_h; oh++) {
        for(int ow=0; ow<out_w; ow++) {
            int row = 0;
            for(int c=0; c<in_c; c++) {
                for(int kh=0; kh<k; kh++) {
                    for(int kw=0; kw<k; kw++) {
                        X[row * padded_N + col] = image[c*(in_h*in_w) + (oh+kh)*in_w + (ow+kw)];
                        row++;
                    }
                }
            }
            for(int p=row; p<padded_K; p++) {
                X[p * padded_N + col] = 0;
            }
            col++;
        }
    }
    for(int row=0; row<padded_K; row++) {
        for(int c=actual_N; c<padded_N; c++) {
            X[row * padded_N + c] = 0;
        }
    }
}

void maxpool2d(const int8_t* in_fmap, int8_t* out_fmap, int c, int in_h, int in_w) {
    int out_h = in_h / 2;
    int out_w = in_w / 2;
    for(int ch=0; ch<c; ch++) {
        for(int oh=0; oh<out_h; oh++) {
            for(int ow=0; ow<out_w; ow++) {
                int8_t max_val = -128;
                for(int kh=0; kh<2; kh++) {
                    for(int kw=0; kw<2; kw++) {
                        int8_t val = in_fmap[ch*(in_h*in_w) + (oh*2+kh)*in_w + (ow*2+kw)];
                        if(val > max_val) max_val = val;
                    }
                }
                out_fmap[ch*(out_h*out_w) + oh*out_w + ow] = max_val;
            }
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

typedef struct {
    double total_us;
    double im2col_us;
    double gemm_us;
    double pool_relu_us;
    uint32_t hw_cycles;
} layer_stats_t;

int run_inference(int use_hw, layer_stats_t* stats, int32_t* out_scores) {
    struct timespec t0, t1;
    memset(stats, 0, sizeof(layer_stats_t));

    struct timespec start_total, end_total;
    clock_gettime(CLOCK_MONOTONIC, &start_total);

    // ==========================================
    // Layer 1: Conv1 (3x32x32 -> 6x28x28)
    // ==========================================
    clock_gettime(CLOCK_MONOTONIC, &t0);
    im2col(IMAGE_BUF, X_UNROLLED, 3, 32, 32, 5, 80, 784); // padded K=80, N=784
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->im2col_us += get_time_us(&t0, &t1);

    if (use_hw) {
        pad_and_copy_weights(WEIGHT_PADDED, conv1_weight, 6, 75, 16, 80); // M=16, K=80
        gemmrv_mat A = GEMMRV_MAT(WEIGHT_PADDED, 16, 80, 80);
        gemmrv_mat B = GEMMRV_MAT(X_UNROLLED, 80, 784, 784);
        gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_BUF, 16, 784, 784);

        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A, &B, &C);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    } else {
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(conv1_weight, X_UNROLLED, Y_BUF, 6, 75, 784);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    }

    clock_gettime(CLOCK_MONOTONIC, &t0);
    apply_bias_relu_scale(Y_BUF, FMAP_A, conv1_bias, 6, 784, 784, SHIFT_CONV1);
    maxpool2d(FMAP_A, FMAP_B, 6, 28, 28); // Pool1 -> 6x14x14
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->pool_relu_us += get_time_us(&t0, &t1);

    // ==========================================
    // Layer 2: Conv2 (6x14x14 -> 16x10x10)
    // ==========================================
    clock_gettime(CLOCK_MONOTONIC, &t0);
    im2col(FMAP_B, X_UNROLLED, 6, 14, 14, 5, 160, 112); // padded K=160, N=112
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->im2col_us += get_time_us(&t0, &t1);

    if (use_hw) {
        pad_and_copy_weights(WEIGHT_PADDED, conv2_weight, 16, 150, 16, 160);
        gemmrv_mat A2 = GEMMRV_MAT(WEIGHT_PADDED, 16, 160, 160);
        gemmrv_mat B2 = GEMMRV_MAT(X_UNROLLED, 160, 112, 112);
        gemmrv_mat_out C2 = GEMMRV_MAT_OUT(Y_BUF, 16, 112, 112);

        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A2, &B2, &C2);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    } else {
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(conv2_weight, X_UNROLLED, Y_BUF, 16, 150, 112);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    }

    clock_gettime(CLOCK_MONOTONIC, &t0);
    apply_bias_relu_scale(Y_BUF, FMAP_A, conv2_bias, 16, 100, 112, SHIFT_CONV2);
    maxpool2d(FMAP_A, FMAP_B, 16, 10, 10); // Pool2 -> 16x5x5 (400)
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->pool_relu_us += get_time_us(&t0, &t1);

    // ==========================================
    // Layer 3: FC1 (400 -> 120)
    // ==========================================
    if (use_hw) {
        pad_and_copy_weights(WEIGHT_PADDED, fc1_weight, 120, 400, 128, 400);
        gemmrv_mat A3 = GEMMRV_MAT(WEIGHT_PADDED, 128, 400, 400);
        gemmrv_mat B3 = GEMMRV_MAT(FMAP_B, 400, 16, 1);
        gemmrv_mat_out C3 = GEMMRV_MAT_OUT(Y_BUF, 128, 16, 16);

        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A3, &B3, &C3);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    } else {
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(fc1_weight, FMAP_B, Y_BUF, 120, 400, 1);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    }

    clock_gettime(CLOCK_MONOTONIC, &t0);
    int stride_fc1 = use_hw ? 16 : 1;
    apply_bias_relu_scale(Y_BUF, FMAP_A, fc1_bias, 120, 1, stride_fc1, SHIFT_FC1);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->pool_relu_us += get_time_us(&t0, &t1);

    // ==========================================
    // Layer 4: FC2 (120 -> 84)
    // ==========================================
    if (use_hw) {
        pad_and_copy_weights(WEIGHT_PADDED, fc2_weight, 84, 120, 96, 128);
        gemmrv_mat A4 = GEMMRV_MAT(WEIGHT_PADDED, 96, 128, 128);
        gemmrv_mat B4 = GEMMRV_MAT(FMAP_A, 128, 16, 1);
        gemmrv_mat_out C4 = GEMMRV_MAT_OUT(Y_BUF, 96, 16, 16);

        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A4, &B4, &C4);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    } else {
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(fc2_weight, FMAP_A, Y_BUF, 84, 120, 1);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    }

    clock_gettime(CLOCK_MONOTONIC, &t0);
    int stride_fc2 = use_hw ? 16 : 1;
    apply_bias_relu_scale(Y_BUF, FMAP_B, fc2_bias, 84, 1, stride_fc2, SHIFT_FC2);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    stats->pool_relu_us += get_time_us(&t0, &t1);

    // ==========================================
    // Layer 5: FC3 (84 -> 23 Classes)
    // ==========================================
    if (use_hw) {
        pad_and_copy_weights(WEIGHT_PADDED, fc3_weight, 23, 84, 32, 96);
        gemmrv_mat A5 = GEMMRV_MAT(WEIGHT_PADDED, 32, 96, 96);
        gemmrv_mat B5 = GEMMRV_MAT(FMAP_B, 96, 16, 1);
        gemmrv_mat_out C5 = GEMMRV_MAT_OUT(Y_BUF, 32, 16, 16);

        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A5, &B5, &C5);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    } else {
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(fc3_weight, FMAP_B, Y_BUF, 23, 84, 1);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        stats->gemm_us += get_time_us(&t0, &t1);
    }

    // Argmax evaluation
    int stride_fc3 = use_hw ? 16 : 1;
    int best_class = 0;
    int32_t best_score = Y_BUF[0 * stride_fc3] + fc3_bias[0];
    if(out_scores) out_scores[0] = best_score;
    for(int i=1; i<23; i++) {
        int32_t score = Y_BUF[i * stride_fc3] + fc3_bias[i];
        if(out_scores) out_scores[i] = score;
        if(score > best_score) {
            best_score = score;
            best_class = i;
        }
    }

    clock_gettime(CLOCK_MONOTONIC, &end_total);
    stats->total_us = get_time_us(&start_total, &end_total);
    stats->hw_cycles = hw_get_perf_cycles();

    return best_class;
}

int main() {
    printf("\n============================================================\n");
    printf("   Full LeNet-5 CNN Inference on PolarFire SoC FPGA\n");
    printf("============================================================\n");

    // Initialize mock image (RGB 3x32x32)
    for(int i = 0; i < 3 * 32 * 32; i++) {
        IMAGE_BUF[i] = (int8_t)((i % 25) - 12);
    }

    layer_stats_t sw_stats, hw_stats;
    int32_t sw_scores[23], hw_scores[23];

    printf("[*] Running Pure Software Baseline Inference...\n");
    int sw_class = run_inference(0, &sw_stats, sw_scores);

    printf("[*] Running Hardware-Accelerated LeNet Inference...\n");
    hw_reset_perf_counters();
    int hw_class = run_inference(1, &hw_stats, hw_scores);

    printf("\n-------------------- INFERENCE RESULTS --------------------\n");
    printf("SW Predicted Class ID : %d (%s)\n", sw_class, color_names[sw_class]);
    printf("HW Predicted Class ID : %d (%s)\n", hw_class, color_names[hw_class]);

    int max_diff = 0;
    int mismatches = 0;
    for(int i = 0; i < 23; i++) {
        int diff = abs(hw_scores[i] - sw_scores[i]);
        if(diff > max_diff) max_diff = diff;
        if(diff > 0) mismatches++;
    }
    printf("Verification          : %s (Max logit diff: %d across 23 classes)\n", 
           (sw_class == hw_class) ? "SUCCESS / MATCH" : "MISMATCH", max_diff);

    printf("\n------------------- TIMING BREAKDOWN (us) -------------------\n");
    printf("%-20s | %-12s | %-12s | %-10s\n", "Phase", "SW (CPU)", "HW System", "Speedup");
    printf("-------------------------------------------------------------\n");
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "im2col transform", sw_stats.im2col_us, hw_stats.im2col_us, sw_stats.im2col_us / hw_stats.im2col_us);
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "GEMM Convolutions", sw_stats.gemm_us, hw_stats.gemm_us, sw_stats.gemm_us / hw_stats.gemm_us);
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "Pool & ReLU & Bias", sw_stats.pool_relu_us, hw_stats.pool_relu_us, sw_stats.pool_relu_us / hw_stats.pool_relu_us);
    printf("-------------------------------------------------------------\n");
    printf("%-20s | %10.1f us | %10.1f us | %8.2fx\n", "TOTAL END-TO-END", sw_stats.total_us, hw_stats.total_us, sw_stats.total_us / hw_stats.total_us);
    
    double hw_ip_time = (double)hw_stats.hw_cycles / 100.0;
    printf("HW Pure IP Time       : %.1f us (%u cycles @ 100 MHz)\n", hw_ip_time, hw_stats.hw_cycles);
    printf("Pure GEMM IP Speedup  : %.2fx\n", sw_stats.gemm_us / hw_ip_time);
    printf("=============================================================\n");

    gemmrv_close();
    return 0;
}
