#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include "gemmrv_hw.h"

#define MATRIX_SIZE 64

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
    printf("   GEMMrv32 2D Strided Hardware GEMM Demo (64x64)\n");
    printf("============================================================\n");

    if (gemmrv_init() < 0) {
        fprintf(stderr, "Failed to initialize GEMMrv hardware!\n");
        return 1;
    }

    // Allocate matrices directly in mapped DDR space
    // DDR layout:
    // A at offset 0x000000 (64x64 = 4KB)
    // B at offset 0x010000 (64x64 = 4KB)
    // C_hw at offset 0x020000 (64x64*4 = 16KB)
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    off_t page_base = DDR_BASE_PHYS;
    uint8_t *ddr_mem = (uint8_t *)mmap(NULL, 1024*1024, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_base);

    int8_t *raw_A = (int8_t *)(ddr_mem + 0x00000);
    int8_t *raw_B = (int8_t *)(ddr_mem + 0x10000);
    int32_t *raw_C_hw = (int32_t *)(ddr_mem + 0x20000);
    int32_t *raw_C_sw = (int32_t *)malloc(MATRIX_SIZE * MATRIX_SIZE * sizeof(int32_t));

    // Initialize with test data
    for(int i=0; i<MATRIX_SIZE * MATRIX_SIZE; i++) {
        raw_A[i] = (int8_t)((i % 13) - 6);
        raw_B[i] = (int8_t)((i % 17) - 8);
        raw_C_hw[i] = 0;
    }

    gemmrv_mat A = GEMMRV_MAT(raw_A, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    gemmrv_mat B = GEMMRV_MAT(raw_B, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    gemmrv_mat_out C = GEMMRV_MAT_OUT(raw_C_hw, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);

    printf("[HW] Running 2D Strided Zero-Copy Hardware GEMM...\n");
    struct timespec hw_start, hw_end;
    hw_reset_perf_counters();
    clock_gettime(CLOCK_MONOTONIC, &hw_start);
    gemmrv_mult(&A, &B, &C);
    clock_gettime(CLOCK_MONOTONIC, &hw_end);
    double hw_time_us = get_time_us(&hw_start, &hw_end);
    
    uint32_t perf[4];
    hw_read_perf_breakdown(perf);
    uint32_t hw_cycles = perf[0] + perf[1] + perf[2] + perf[3];

    printf("[SW] Running Software Baseline GEMM...\n");
    struct timespec sw_start, sw_end;
    clock_gettime(CLOCK_MONOTONIC, &sw_start);
    gemm_sw_basic(raw_A, raw_B, raw_C_sw, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);
    clock_gettime(CLOCK_MONOTONIC, &sw_end);
    double sw_time_us = get_time_us(&sw_start, &sw_end);

    int errors = 0;
    for(int i=0; i<MATRIX_SIZE * MATRIX_SIZE; i++) {
        if(raw_C_hw[i] != raw_C_sw[i]) {
            if (errors < 10) {
                printf("  Mismatch [%d]: HW=%d, Expected=%d\n", i, raw_C_hw[i], raw_C_sw[i]);
            }
            errors++;
        }
    }

    printf("\n------------------- BENCHMARK RESULTS -------------------\n");
    printf("Verification:         %d Errors across %d elements\n", errors, MATRIX_SIZE * MATRIX_SIZE);
    printf("SW Time (CPU):        %.3f us (%.3f ms)\n", sw_time_us, sw_time_us / 1000.0);
    printf("HW Total System Time: %.3f us (%.3f ms)\n", hw_time_us, hw_time_us / 1000.0);
    printf("HW Cycles Breakdown:\n");
    printf("  Fetch A Cycles:     %u (%.1f us)\n", perf[0], perf[0] / 100.0);
    printf("  Fetch B Cycles:     %u (%.1f us)\n", perf[1], perf[1] / 100.0);
    printf("  Compute Cycles:     %u (%.1f us)\n", perf[2], perf[2] / 100.0);
    printf("  Store C Cycles:     %u (%.1f us)\n", perf[3], perf[3] / 100.0);
    printf("  Total IP Cycles:    %u (%.1f us @ 100 MHz)\n", hw_cycles, hw_cycles / 100.0);
    printf("Real Speedup (SW/HW): %.2fx\n", sw_time_us / hw_time_us);
    printf("IP Speedup (SW/IP):   %.2fx\n", sw_time_us / ((double)hw_cycles / 100.0));
    printf("---------------------------------------------------------\n");

    free(raw_C_sw);
    gemmrv_close();
    close(fd);
    return 0;
}
