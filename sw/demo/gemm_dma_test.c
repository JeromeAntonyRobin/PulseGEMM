#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <time.h>

#define PAGE_SIZE           0x1000
#define GEMM_REG_BASE_PHYS  0x60020000 
#define DDR_BASE_PHYS       0x88000000
#define MATRIX_A_PHYS       (DDR_BASE_PHYS + 0x0000)
#define MATRIX_B_PHYS       (DDR_BASE_PHYS + 0x1000)
#define MATRIX_C_PHYS       (DDR_BASE_PHYS + 0x2000)

#define REG_CTRL            (0x00 / 4)
#define REG_STATUS          (0x04 / 4)
#define REG_SRC_A           (0x08 / 4)
#define REG_SRC_B           (0x0C / 4)
#define REG_DST_C           (0x10 / 4)
#define REG_CYCLE_CNT       (0x14 / 4)

#define DIM                 16
#define CLOCK_FREQ_MHZ      50.0

static void *map_physical(int fd, off_t phys_addr, size_t size) {
    off_t page_base = phys_addr & ~(PAGE_SIZE - 1);
    off_t page_offset = phys_addr - page_base;
    void *map = mmap(NULL, size + page_offset, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_base);
    if (map == MAP_FAILED) return NULL;
    return (uint8_t *)map + page_offset;
}

int main(int argc, char **argv) {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) return 1;

    volatile uint32_t *gemm_regs = (volatile uint32_t *)map_physical(fd, GEMM_REG_BASE_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_a = (volatile uint64_t *)map_physical(fd, MATRIX_A_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_b = (volatile uint64_t *)map_physical(fd, MATRIX_B_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_c = (volatile uint64_t *)map_physical(fd, MATRIX_C_PHYS, PAGE_SIZE);

    int8_t host_a[DIM][DIM];
    int8_t host_b[DIM][DIM];
    int32_t golden_c[DIM][DIM];

    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            host_a[r][c] = (int8_t)((r * 3 - c * 2) % 15);
            host_b[r][c] = (r == c) ? (int8_t)2 : (int8_t)(((r + c) % 5) - 2);
        }
    }

    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            golden_c[r][c] = 0;
            for (int k = 0; k < DIM; k++) {
                golden_c[r][c] += (int32_t)host_a[r][k] * (int32_t)host_b[k][c];
            }
        }
    }

    // Write spaced by 64-bits (8 bytes) to align with ARSIZE=3
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c += 4) {
            uint32_t word_a = ((uint8_t)host_a[r][c]) | (((uint8_t)host_a[r][c+1]) << 8) | (((uint8_t)host_a[r][c+2]) << 16) | (((uint8_t)host_a[r][c+3]) << 24);
            uint32_t word_b = ((uint8_t)host_b[r][c]) | (((uint8_t)host_b[r][c+1]) << 8) | (((uint8_t)host_b[r][c+2]) << 16) | (((uint8_t)host_b[r][c+3]) << 24);
            mat_a[(r * DIM + c) / 4] = (uint64_t)word_a;
            mat_b[(r * DIM + c) / 4] = (uint64_t)word_b;
        }
    }

    gemm_regs[REG_SRC_A] = (uint32_t)MATRIX_A_PHYS;
    gemm_regs[REG_SRC_B] = (uint32_t)MATRIX_B_PHYS;
    gemm_regs[REG_DST_C] = (uint32_t)MATRIX_C_PHYS;

    gemm_regs[REG_CTRL] = 0x00000001;
    uint32_t status = 0;
    uint32_t timeout = 1000000;
    while (timeout--) {
        status = gemm_regs[REG_STATUS];
        if (status & 0x02) break;
    }

    int errors = 0;
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            int32_t hw_val = (int32_t)mat_c[r * DIM + c]; // Read lower 32-bits of the 64-bit element
            if (hw_val != golden_c[r][c]) {
                if (errors < 10) {
                    printf("    Mismatch at [%d][%d]: HW=%d, Expected=%d\n", r, c, hw_val, golden_c[r][c]);
                }
                errors++;
            }
        }
    }
    printf("Errors: %d\n", errors);
    close(fd);
    return 0;
}
