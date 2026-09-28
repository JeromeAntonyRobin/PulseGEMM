#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "gemmrv_hw.h"

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

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
}

int test_matrix_shape(int M, int K, int N, int test_id) {
    uint8_t* ddr_work = gemmrv_get_ddr_base();
    
    int8_t* W_src = malloc(M * K);
    int8_t* X_src = (int8_t*)(ddr_work + 0x000000);
    int32_t* Y_hw = (int32_t*)(ddr_work + 0x400000);
    int8_t* W_pad = (int8_t*)(ddr_work + 0x800000);
    int32_t* Y_sw = malloc(M * N * sizeof(int32_t));
    
    srand(test_id * 100 + 7);
    for(int i=0; i<M*K; i++) W_src[i] = (rand() % 255) - 128;
    for(int i=0; i<K*N; i++) X_src[i] = (rand() % 255) - 128;
    memset(Y_hw, 0, M * N * sizeof(int32_t));
    memset(Y_sw, 0, M * N * sizeof(int32_t));

    pad_and_copy_weights(W_pad, W_src, M, K, M, K);

    gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
    gemmrv_mat B = GEMMRV_MAT(X_src, K, N, N);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_hw, M, N, N);

    struct timespec t0, t1;

    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemm_sw(W_src, X_src, Y_sw, M, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double sw_us = get_time_us(&t0, &t1);

    hw_reset_perf_counters();
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double hw_us = get_time_us(&t0, &t1);

    uint32_t perf[4];
    hw_read_perf_breakdown(perf);

    int errors = 0;
    int max_diff = 0;

    for (int i = 0; i < M * N; i++) {
        int diff = abs(Y_sw[i] - Y_hw[i]);
        if (diff > 0) {
            errors++;
            if (diff > max_diff) max_diff = diff;
        }
    }

    printf("Test #%d [%3dx%3dx%3d]: ", test_id, M, K, N);
    if (errors == 0) {
        printf("PASS | SW: %10.1f us | HW: %8.1f us | Speedup: %5.2fx\n", sw_us, hw_us, sw_us / hw_us);
    } else {
        printf("FAIL | Errors: %d/%d (Max Diff: %d)\n", errors, M*N, max_diff);
    }

    free(W_src);
    free(Y_sw);
    return errors;
}

int test_b_burst_shape(int M, int K, int N) {
    uint8_t* ddr_work = gemmrv_get_ddr_base();
    
    int8_t* W_src = malloc(M * K);
    int8_t* X_src = malloc(K * N);
    int8_t* W_pad = (int8_t*)(ddr_work + 0x000000);
    int8_t* X_pad = (int8_t*)(ddr_work + 0x200000);
    int32_t* Y_hw = (int32_t*)(ddr_work + 0x400000);
    int32_t* Y_sw = malloc(M * N * sizeof(int32_t));
    
    srand(42);
    for(int i=0; i<M*K; i++) W_src[i] = (rand() % 255) - 128;
    for(int i=0; i<K*N; i++) X_src[i] = (rand() % 255) - 128;
    memset(Y_hw, 0, M * N * sizeof(int32_t));

    pad_and_copy_weights(W_pad, W_src, M, K, M, K);
    pad_and_copy_weights(X_pad, X_src, K, N, K, N);

    gemmrv_mat A = GEMMRV_MAT(W_pad, M, K, K);
    gemmrv_mat B = GEMMRV_MAT(X_pad, K, N, 16); // stride_B = 16 triggers B-burst!
    gemmrv_mat_out C = GEMMRV_MAT_OUT(Y_hw, M, N, N);

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemm_sw(W_src, X_src, Y_sw, M, K, N);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double sw_us = get_time_us(&t0, &t1);

    hw_reset_perf_counters();
    clock_gettime(CLOCK_MONOTONIC, &t0);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double hw_us = get_time_us(&t0, &t1);

    uint32_t perf[4];
    hw_read_perf_breakdown(perf);

    int errors = 0;
    for (int i = 0; i < M * N; i++) {
        if (Y_sw[i] != Y_hw[i]) errors++;
    }

    printf("\n[B-BURST TEST %3dx%3dx%3d]: %s | SW: %10.1f us | HW: %8.1f us | Speedup: %5.2fx\n",
           M, K, N, (errors==0?"PASS":"FAIL"), sw_us, hw_us, sw_us / hw_us);
    printf("   Perf Cycles Breakdown: Fetch A: %u | Fetch B: %u | Compute: %u | Store C: %u\n\n",
           perf[0], perf[1], perf[2], perf[3]);

    free(W_src);
    free(X_src);
    free(Y_sw);
    return errors;
}

int main() {
    if (gemmrv_init() < 0) {
        printf("Failed to init HW\n");
        return 1;
    }

    printf("============================================================\n");
    printf("   EXTENSIVE DATA INTEGRITY & SPEEDUP VERIFICATION SUITE   \n");
    printf("============================================================\n");

    int total_errors = 0;
    
    total_errors += test_matrix_shape(16, 16, 16, 1);
    total_errors += test_matrix_shape(16, 32, 16, 2);
    total_errors += test_matrix_shape(32, 64, 32, 3);
    total_errors += test_matrix_shape(64, 128, 64, 4);
    total_errors += test_matrix_shape(128, 256, 128, 5);
    total_errors += test_matrix_shape(128, 576, 256, 6);
    total_errors += test_matrix_shape(256, 512, 256, 7);
    total_errors += test_matrix_shape(256, 1152, 256, 8);

    total_errors += test_b_burst_shape(128, 576, 256);

    printf("============================================================\n");
    if (total_errors == 0) {
        printf("ALL TESTS PASSED PERFECTLY! 100%% DATA INTEGRITY VERIFIED.\n");
    } else {
        printf("TEST SUITE FAILED WITH %d TOTAL ERRORS!\n", total_errors);
    }
    printf("============================================================\n");

    return 0;
}
