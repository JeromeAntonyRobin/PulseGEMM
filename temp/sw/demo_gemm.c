#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include "gemm_lib/gemmrv_hw.h"

#define MATRIX_SIZE 64

static int8_t raw_A[MATRIX_SIZE * MATRIX_SIZE];
static int8_t raw_B[MATRIX_SIZE * MATRIX_SIZE];
static int32_t raw_C_hw[MATRIX_SIZE * MATRIX_SIZE];
static int32_t raw_C_sw[MATRIX_SIZE * MATRIX_SIZE];

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
}

void gemm_sw_basic(const int8_t* A, const int8_t* B, int32_t* C, int M, int K, int N) {
    for(int m=0; m<M; m++) {
        for(int n=0; n<N; n++) {
            int32_t acc = 0;
            for(int k=0; k<K; k++) {
                acc += (int32_t)A[m * K + k] * (int32_t)B[k * N + n];
            }
            C[m * N + n] = acc;
        }
    }
}

int main() {
    printf("\n============================================================\n");
    printf("   GEMMrv32 Large Matrix Multiplication Demo (64x64)\n");
    printf("============================================================\n");

    // Initialize with test data
    for(int i=0; i<MATRIX_SIZE * MATRIX_SIZE; i++) {
        raw_A[i] = (int8_t)((i % 13) - 6);
        raw_B[i] = (int8_t)((i % 17) - 8);
    }

    gemmrv_mat A = GEMMRV_MAT(raw_A, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    gemmrv_mat B = GEMMRV_MAT(raw_B, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(raw_C_hw, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);

    printf("[HW] Running Hardware Tiled GEMM (gemmrv_mult)...\n");
    struct timespec hw_start, hw_end;
    hw_reset_perf_counters();
    clock_gettime(CLOCK_MONOTONIC, &hw_start);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &hw_end);
    double hw_time_us = get_time_us(&hw_start, &hw_end);
    uint32_t hw_cycles = hw_get_perf_cycles();

    printf("[SW] Running Software GEMM for verification...\n");
    struct timespec sw_start, sw_end;
    clock_gettime(CLOCK_MONOTONIC, &sw_start);
    gemm_sw_basic(raw_A, raw_B, raw_C_sw, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    clock_gettime(CLOCK_MONOTONIC, &sw_end);
    double sw_time_us = get_time_us(&sw_start, &sw_end);

    int errors = 0;
    for(int i=0; i<MATRIX_SIZE * MATRIX_SIZE; i++) {
        if(raw_C_hw[i] != raw_C_sw[i]) {
            errors++;
        }
    }

    printf("\n------------------- BENCHMARK RESULTS -------------------\n");
    printf("Verification:         %d Errors across %d elements\n", errors, MATRIX_SIZE * MATRIX_SIZE);
    printf("SW Time (CPU):        %.3f us (%.3f ms)\n", sw_time_us, sw_time_us / 1000.0);
    printf("HW Total System Time: %.3f us (%.3f ms)\n", hw_time_us, hw_time_us / 1000.0);
    printf("HW Pure IP Time:      %.3f us (%u cycles @ 100 MHz)\n", (double)hw_cycles / 100.0, hw_cycles);
    printf("Real Speedup (SW/HW): %.2fx\n", sw_time_us / hw_time_us);
    printf("IP Speedup (SW/IP):   %.2fx\n", sw_time_us / ((double)hw_cycles / 100.0));
    printf("---------------------------------------------------------\n");

    gemmrv_close();
    return 0;
}
