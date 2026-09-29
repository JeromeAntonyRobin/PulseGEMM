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
    const char* name;
    int M; // Out Channels
    int in_c;
    int in_h;
    int in_w;
    int k_size;
} resnet_layer_t;

// Representative Bottleneck Building Blocks across ResNet stages
resnet_layer_t resnet_stages[] = {
    {"ResNet Stage 2 (Conv2_x 3x3 Bottleneck)", 64,  64,  56, 56, 3}, // Spatial 56x56 -> 54x54 (N=2916->3072)
    {"ResNet Stage 3 (Conv3_x 3x3 Bottleneck)", 128, 128, 28, 28, 3}, // Spatial 28x28 -> 26x26 (N=676->768)
    {"ResNet Stage 4 (Conv4_x 3x3 Bottleneck)", 256, 256, 16, 16, 3}, // Spatial 16x16 -> 14x14 (N=196->256)
    {"ResNet Stage 5 (Conv5_x 3x3 Bottleneck)", 512, 512, 9,  9,  3}  // Spatial 9x9 -> 7x7 (N=49->64)
};

int main() {
    printf("============================================================\n");
    printf("     FULL MULTI-STAGE RESNET CONVOLUTIONAL INFERENCE        \n");
    printf("============================================================\n");
    if (gemmrv_init() < 0) {
        fprintf(stderr, "Failed to initialize GEMMrv hardware!\n");
        return 1;
    }

    uint8_t* ddr_work = gemmrv_get_ddr_base();
    int8_t* W_pad   = (int8_t*)(ddr_work + 0x000000);
    int8_t* IMAGE   = (int8_t*)(ddr_work + 0x200000);
    int8_t* X_UNR   = (int8_t*)(ddr_work + 0x400000);
    int32_t* Y_HW   = (int32_t*)(ddr_work + 0x700000);
    int8_t* OUT_HW  = (int8_t*)(ddr_work + 0x900000);

    double total_sw_time = 0;
    double total_hw_time = 0;
    double total_sw_gemm = 0;
    double total_hw_gemm = 0;
    double total_mac_ops = 0;

    int num_layers = sizeof(resnet_stages) / sizeof(resnet_stages[0]);

    for (int l = 0; l < num_layers; l++) {
        resnet_layer_t layer = resnet_stages[l];
        int out_h = layer.in_h - layer.k_size + 1;
        int out_w = layer.in_w - layer.k_size + 1;
        int raw_N = out_h * out_w;
        int raw_K = layer.in_c * layer.k_size * layer.k_size;

        int M = ((layer.M + 15) / 16) * 16;
        int K = ((raw_K + 15) / 16) * 16;
        int N = ((raw_N + 15) / 16) * 16;

        int8_t* W_src = malloc(M * K);
        int32_t* bias = malloc(M * sizeof(int32_t));
        int32_t* Y_SW = malloc(M * N * sizeof(int32_t));
        int8_t* OUT_SW = malloc(M * N);

        for (int i = 0; i < M * K; i++) W_src[i] = (i % 17) - 8;
        for (int i = 0; i < layer.in_c * layer.in_h * layer.in_w; i++) IMAGE[i] = (i % 11) - 5;
        for (int i = 0; i < M; i++) bias[i] = (i % 7) - 3;

        pad_and_copy_weights(W_pad, W_src, M, K, M, K);

        gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
        gemmrv_mat B = GEMMRV_MAT(X_UNR, K, N, N);
        gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_HW, M, N, N);

        struct timespec t0, t1, t_start, t_end;

        // 1. SW Run
        clock_gettime(CLOCK_MONOTONIC, &t_start);
        im2col(IMAGE, X_UNR, layer.in_c, layer.in_h, layer.in_w, layer.k_size, K, N);
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemm_sw(W_src, X_UNR, Y_SW, M, K, N);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        double sw_gemm = get_time_us(&t0, &t1);
        apply_bias_relu_scale(Y_SW, OUT_SW, bias, layer.M, raw_N, N, 2);
        clock_gettime(CLOCK_MONOTONIC, &t_end);
        double sw_total = get_time_us(&t_start, &t_end);

        // 2. HW Run
        clock_gettime(CLOCK_MONOTONIC, &t_start);
        im2col(IMAGE, X_UNR, layer.in_c, layer.in_h, layer.in_w, layer.k_size, K, N);
        clock_gettime(CLOCK_MONOTONIC, &t0);
        gemmrv_mult(&A, &B, &C);
        clock_gettime(CLOCK_MONOTONIC, &t1);
        double hw_gemm = get_time_us(&t0, &t1);
        apply_bias_relu_scale(Y_HW, OUT_HW, bias, layer.M, raw_N, N, 2);
        clock_gettime(CLOCK_MONOTONIC, &t_end);
        double hw_total = get_time_us(&t_start, &t_end);

        // Verify correctness
        int errors = 0;
        for (int i = 0; i < layer.M * raw_N; i++) {
            if (OUT_SW[i] != OUT_HW[i]) errors++;
        }

        double macs = (double)M * (double)K * (double)N;
        total_mac_ops += macs;
        total_sw_time += sw_total;
        total_hw_time += hw_total;
        total_sw_gemm += sw_gemm;
        total_hw_gemm += hw_gemm;

        printf("\n[*] %s\n", layer.name);
        printf("    Shape: M=%d, K=%d, N=%d (%.2f MMACs) | Verify: %s\n",
               M, K, N, macs / 1e6, errors == 0 ? "PASS (0 Errors)" : "FAIL");
        printf("    GEMM Speedup      : SW %9.1f us -> HW %8.1f us | Speedup: %5.2fx\n",
               sw_gemm, hw_gemm, sw_gemm / hw_gemm);
        printf("    Total Layer Time  : SW %9.1f us -> HW %8.1f us | Speedup: %5.2fx\n",
               sw_total, hw_total, sw_total / hw_total);

        free(W_src);
        free(bias);
        free(Y_SW);
        free(OUT_SW);
    }

    printf("\n============================================================\n");
    printf("        FULL MULTI-STAGE RESNET INFERENCE SUMMARY           \n");
    printf("============================================================\n");
    printf(" Total Compute Workload : %.2f MMACs\n", total_mac_ops / 1e6);
    printf(" Pure GEMM Convolution  : SW %10.1f ms -> HW %8.1f ms | Speedup: %5.2fx\n",
           total_sw_gemm / 1000.0, total_hw_gemm / 1000.0, total_sw_gemm / total_hw_gemm);
    printf(" Full End-to-End Pipeline: SW %10.1f ms -> HW %8.1f ms | Speedup: %5.2fx\n",
           total_sw_time / 1000.0, total_hw_time / 1000.0, total_sw_time / total_hw_time);
    printf("============================================================\n");

    return 0;
}
