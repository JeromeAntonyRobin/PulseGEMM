#include "gemmrv_hw.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int mem_fd = -1;
static volatile uint32_t *gemm_regs = NULL;
static uint8_t *ddr_base_ptr = NULL;

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
    // Map 32MB DDR workspace starting at DDR_BASE_PHYS
    ddr_base_ptr = (uint8_t *)map_physical(mem_fd, DDR_BASE_PHYS, 32 * 1024 * 1024);

    if (!gemm_regs || !ddr_base_ptr) {
        fprintf(stderr, "[GEMMRV] mmap failed!\n");
        return -1;
    }

    return 0;
}

void gemmrv_close(void) {
    if (mem_fd >= 0) {
        close(mem_fd);
        mem_fd = -1;
    }
}

void hw_reset_perf_counters(void) {
    if (gemm_regs) {
        gemm_regs[REG_CTRL] = (1 << 3); // Reset perf counters
    }
}

void hw_read_perf_breakdown(uint32_t out[4]) {
    if (gemm_regs) {
        out[0] = gemm_regs[REG_PERF_FETCH_A];
        out[1] = gemm_regs[REG_PERF_FETCH_B];
        out[2] = gemm_regs[REG_PERF_COMPUTE];
        out[3] = gemm_regs[REG_PERF_STORE_C];
    }
}

uint32_t hw_get_perf_cycles(void) {
    if (!gemm_regs) return 0;
    return gemm_regs[REG_PERF_FETCH_A] + gemm_regs[REG_PERF_FETCH_B] + 
           gemm_regs[REG_PERF_COMPUTE] + gemm_regs[REG_PERF_STORE_C];
}

// Low-level hardware 2D strided tile execution (Zero CPU repacking!)
static inline void hw_gemm_tile(uint32_t phys_A, uint32_t phys_B, uint32_t phys_C,
                                int stride_A, int stride_B, int stride_C,
                                int tile_M, int tile_K, int tile_N,
                                int clear, int store) {
    gemm_regs[REG_SRC_A]    = phys_A;
    gemm_regs[REG_SRC_B]    = phys_B;
    gemm_regs[REG_DST_C]    = phys_C;
    gemm_regs[REG_STRIDE_A] = (uint32_t)stride_A;
    gemm_regs[REG_STRIDE_B] = (uint32_t)stride_B;
    gemm_regs[REG_STRIDE_C] = (uint32_t)stride_C;
    gemm_regs[REG_BOUNDS]   = ((tile_N & 0xFF) << 24) | ((tile_M & 0xFF) << 16) | (tile_K & 0xFFFF);

    uint32_t cmd = 1; // start=1
    if (clear) cmd |= 2; // clear_acc=1
    if (store) cmd |= 4; // store_c=1

    asm volatile ("fence" ::: "memory");
    gemm_regs[REG_CTRL] = cmd;

    // Wait for hardware completion (bit 2 is dma_done: {29'd0, dma_done, dma_err, dma_busy})
    while (!(gemm_regs[REG_STATUS] & 0x04));

    asm volatile ("fence" ::: "memory");
}

void gemmrv_mult(const gemmrv_mat* A, const gemmrv_mat* B, gemmrv_mat_out* C) {
    if (gemmrv_init() < 0) return;

    int M = A->rows;
    int K = A->cols;
    int N = B->cols;

    // Convert virtual pointers in the mapped DDR space to physical DDR addresses
    uint32_t phys_base_A = (uint32_t)(DDR_BASE_PHYS + ((uint8_t*)A->data - ddr_base_ptr));
    uint32_t phys_base_B = (uint32_t)(DDR_BASE_PHYS + ((uint8_t*)B->data - ddr_base_ptr));
    uint32_t phys_base_C = (uint32_t)(DDR_BASE_PHYS + ((uint8_t*)C->data - ddr_base_ptr));

    for (int m = 0; m < M; m += HW_TILE_SIZE) {
        int tile_M = (M - m < HW_TILE_SIZE) ? (M - m) : HW_TILE_SIZE;
        for (int n = 0; n < N; n += HW_TILE_SIZE) {
            int tile_N = (N - n < HW_TILE_SIZE) ? (N - n) : HW_TILE_SIZE;

            uint32_t tile_A_addr = phys_base_A + (m * A->stride);
            uint32_t tile_B_addr = phys_base_B + n;
            uint32_t tile_C_addr = phys_base_C + ((m * C->stride + n) * sizeof(int32_t));

            hw_gemm_tile(tile_A_addr, tile_B_addr, tile_C_addr,
                         A->stride, B->stride, C->stride,
                         tile_M, K, tile_N,
                         1, 1);
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
