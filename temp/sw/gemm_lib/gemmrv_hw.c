#include "gemmrv_hw.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int mem_fd = -1;
static volatile uint32_t *gemm_regs = NULL;
static volatile uint64_t *mat_a_dma = NULL;
static volatile uint64_t *mat_b_dma = NULL;
static volatile uint64_t *mat_c_dma = NULL;

static uint32_t total_hw_cycles_accum = 0;

static void *map_physical(int fd, off_t phys_addr, size_t size) {
    off_t page_base = phys_addr & ~(PAGE_SIZE - 1);
    off_t page_offset = phys_addr - page_base;
    void *map = mmap(NULL, size + page_offset, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_base);
    if (map == MAP_FAILED) return NULL;
    return (uint8_t *)map + page_offset;
}

int gemmrv_init(void) {
    if (mem_fd >= 0) return 0; // Already initialized

    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd < 0) {
        perror("[GEMMRV] open /dev/mem");
        return -1;
    }

    gemm_regs = (volatile uint32_t *)map_physical(mem_fd, GEMM_REG_BASE_PHYS, PAGE_SIZE);
    mat_a_dma = (volatile uint64_t *)map_physical(mem_fd, MATRIX_A_PHYS, PAGE_SIZE);
    mat_b_dma = (volatile uint64_t *)map_physical(mem_fd, MATRIX_B_PHYS, PAGE_SIZE);
    mat_c_dma = (volatile uint64_t *)map_physical(mem_fd, MATRIX_C_PHYS, PAGE_SIZE);

    if (!gemm_regs || !mat_a_dma || !mat_b_dma || !mat_c_dma) {
        fprintf(stderr, "[GEMMRV] mmap failed!\n");
        return -1;
    }

    // Pre-program DMA base addresses
    gemm_regs[REG_SRC_A] = (uint32_t)MATRIX_A_PHYS;
    gemm_regs[REG_SRC_B] = (uint32_t)MATRIX_B_PHYS;
    gemm_regs[REG_DST_C] = (uint32_t)MATRIX_C_PHYS;

    total_hw_cycles_accum = 0;
    return 0;
}

void gemmrv_close(void) {
    if (mem_fd >= 0) {
        close(mem_fd);
        mem_fd = -1;
    }
}

void hw_reset_perf_counters(void) {
    total_hw_cycles_accum = 0;
}

uint32_t hw_get_perf_cycles(void) {
    return total_hw_cycles_accum;
}

// Low-level hardware 16x16 tile execution
static inline void hw_tile_16x16(const int8_t* A_tile_ptr, int stride_A, int tile_M, int tile_K,
                                 const int8_t* B_tile_ptr, int stride_B, int tile_N,
                                 int32_t c_acc[HW_TILE_SIZE][HW_TILE_SIZE]) {
    // 1. Pack Matrix A (16x16) into 64-bit spaced DDR words with bounds padding
    for (int r = 0; r < HW_TILE_SIZE; r++) {
        for (int c = 0; c < HW_TILE_SIZE; c += 4) {
            uint32_t word = 0;
            if (r < tile_M) {
                uint8_t b0 = (c + 0 < tile_K) ? (uint8_t)A_tile_ptr[r * stride_A + (c + 0)] : 0;
                uint8_t b1 = (c + 1 < tile_K) ? (uint8_t)A_tile_ptr[r * stride_A + (c + 1)] : 0;
                uint8_t b2 = (c + 2 < tile_K) ? (uint8_t)A_tile_ptr[r * stride_A + (c + 2)] : 0;
                uint8_t b3 = (c + 3 < tile_K) ? (uint8_t)A_tile_ptr[r * stride_A + (c + 3)] : 0;
                word = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
            }
            mat_a_dma[(r * HW_TILE_SIZE + c) / 4] = (uint64_t)word;
        }
    }

    // 2. Pack Matrix B (16x16) into 64-bit spaced DDR words with bounds padding
    for (int r = 0; r < HW_TILE_SIZE; r++) {
        for (int c = 0; c < HW_TILE_SIZE; c += 4) {
            uint32_t word = 0;
            if (r < tile_K) {
                uint8_t b0 = (c + 0 < tile_N) ? (uint8_t)B_tile_ptr[r * stride_B + (c + 0)] : 0;
                uint8_t b1 = (c + 1 < tile_N) ? (uint8_t)B_tile_ptr[r * stride_B + (c + 1)] : 0;
                uint8_t b2 = (c + 2 < tile_N) ? (uint8_t)B_tile_ptr[r * stride_B + (c + 2)] : 0;
                uint8_t b3 = (c + 3 < tile_N) ? (uint8_t)B_tile_ptr[r * stride_B + (c + 3)] : 0;
                word = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
            }
            mat_b_dma[(r * HW_TILE_SIZE + c) / 4] = (uint64_t)word;
        }
    }

    // 3. Trigger Hardware Accelerator
    gemm_regs[REG_CTRL] = 0x00000001;
    while (!(gemm_regs[REG_STATUS] & 0x02)); // Wait for completion

    total_hw_cycles_accum += gemm_regs[REG_CYCLE_CNT];

    // 4. Accumulate into tile buffer
    for (int r = 0; r < tile_M; r++) {
        for (int c = 0; c < tile_N; c++) {
            c_acc[r][c] += (int32_t)mat_c_dma[r * HW_TILE_SIZE + c];
        }
    }
}

void gemmrv_mult(const gemmrv_mat* A, const gemmrv_mat* B, gemmrv_mat_out* C) {
    if (gemmrv_init() < 0) return;

    int M = A->rows;
    int K = A->cols;
    int N = B->cols;

    for (int m = 0; m < M; m += HW_TILE_SIZE) {
        int tile_M = (M - m < HW_TILE_SIZE) ? (M - m) : HW_TILE_SIZE;
        for (int n = 0; n < N; n += HW_TILE_SIZE) {
            int tile_N = (N - n < HW_TILE_SIZE) ? (N - n) : HW_TILE_SIZE;

            int32_t c_acc[HW_TILE_SIZE][HW_TILE_SIZE] = {0};

            for (int k = 0; k < K; k += HW_TILE_SIZE) {
                int tile_K = (K - k < HW_TILE_SIZE) ? (K - k) : HW_TILE_SIZE;

                const int8_t* A_ptr = &(A->data[m * A->stride + k]);
                const int8_t* B_ptr = &(B->data[k * B->stride + n]);

                hw_tile_16x16(A_ptr, A->stride, tile_M, tile_K,
                              B_ptr, B->stride, tile_N,
                              c_acc);
            }

            // Write back final accumulated tile into C
            for (int r = 0; r < tile_M; r++) {
                for (int c = 0; c < tile_N; c++) {
                    C->data[(m + r) * C->stride + (n + c)] = c_acc[r][c];
                }
            }
        }
    }
}

void gemmrv_post_process(gemmrv_mat_out* C, const int32_t* bias, int shift, int enable_relu) {
    for (int m = 0; m < C->rows; m++) {
        for (int n = 0; n < C->cols; n++) {
            int32_t val = C->data[m * C->stride + n];
            if (bias) {
                val += bias[n];
            }
            if (enable_relu && val < 0) {
                val = 0;
            }
            if (shift > 0) {
                val = val >> shift;
            }
            C->data[m * C->stride + n] = val;
        }
    }
}
