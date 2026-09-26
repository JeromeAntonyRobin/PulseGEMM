/*
 * =============================================================================
 * PolarFire SoC Discovery Kit - GEMM AXI DMA Accelerator Test Application
 * Runs under Yocto Linux on the RISC-V MSS (Processing Subsystem)
 * =============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <time.h>

#define PAGE_SIZE           0x1000

// Hardware Base Addresses
// Default FIC0 MMIO Address for GEMM DMA Control Registers
#define GEMM_REG_BASE_PHYS  0x60020000 

// Physical DDR buffers (located in available DDR RAM above kernel)
#define DDR_BASE_PHYS       0x88000000
#define MATRIX_A_PHYS       (DDR_BASE_PHYS + 0x0000) // 256 bytes
#define MATRIX_B_PHYS       (DDR_BASE_PHYS + 0x1000) // 256 bytes
#define MATRIX_C_PHYS       (DDR_BASE_PHYS + 0x2000) // 1024 bytes

// Register Offsets (in 32-bit word indices)
#define REG_CTRL            (0x00 / 4) // [0]: START, [1]: IRQ_EN, [2]: ACCUM_EN
#define REG_STATUS          (0x04 / 4) // [0]: BUSY,  [1]: DONE,   [2]: ERR
#define REG_SRC_A           (0x08 / 4) // Physical DDR address of Matrix A
#define REG_SRC_B           (0x0C / 4) // Physical DDR address of Matrix B
#define REG_DST_C           (0x10 / 4) // Physical DDR address of Matrix C
#define REG_CYCLE_CNT       (0x14 / 4) // Hardware cycle counter

#define DIM                 16
#define CLOCK_FREQ_MHZ      50.0

static void *map_physical(int fd, off_t phys_addr, size_t size) {
    off_t page_base = phys_addr & ~(PAGE_SIZE - 1);
    off_t page_offset = phys_addr - page_base;
    void *map = mmap(NULL, size + page_offset, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_base);
    if (map == MAP_FAILED) {
        perror("mmap failed");
        return NULL;
    }
    return (uint8_t *)map + page_offset;
}

int main(int argc, char **argv) {
    printf("===============================================================\n");
    printf("   POLARFIRE SOC GEMM AXI DMA ACCELERATOR BENCHMARK           \n");
    printf("   Target: 16x16 INT8 Systolic Array (256 Processing Elements)\n");
    printf("===============================================================\n");

    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("Error opening /dev/mem (must run as root)");
        return 1;
    }

    // Map GEMM DMA Control Registers
    volatile uint32_t *gemm_regs = (volatile uint32_t *)map_physical(fd, GEMM_REG_BASE_PHYS, PAGE_SIZE);
    if (!gemm_regs) {
        close(fd);
        return 1;
    }

    // Map DDR Memory Buffers
    volatile int8_t  *mat_a = (volatile int8_t *)map_physical(fd, MATRIX_A_PHYS, PAGE_SIZE);
    volatile int8_t  *mat_b = (volatile int8_t *)map_physical(fd, MATRIX_B_PHYS, PAGE_SIZE);
    volatile int32_t *mat_c = (volatile int32_t *)map_physical(fd, MATRIX_C_PHYS, PAGE_SIZE);

    if (!mat_a || !mat_b || !mat_c) {
        printf("Failed to map DDR memory buffers.\n");
        close(fd);
        return 1;
    }

    printf("[1] Populating Matrix A (16x16 INT8) and Matrix B (16x16 INT8) in DDR...\n");
    int8_t host_a[DIM][DIM];
    int8_t host_b[DIM][DIM];
    int32_t golden_c[DIM][DIM];

    // Seed test patterns
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            host_a[r][c] = (int8_t)((r * 3 - c * 2) % 15);
            host_b[r][c] = (r == c) ? (int8_t)2 : (int8_t)(((r + c) % 5) - 2);

            mat_a[r * DIM + c] = host_a[r][c];
            mat_b[r * DIM + c] = host_b[r][c];
            mat_c[r * DIM + c] = 0; // Clear output
        }
    }

    // Compute CPU golden reference
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            golden_c[r][c] = 0;
            for (int k = 0; k < DIM; k++) {
                golden_c[r][c] += (int32_t)host_a[r][k] * (int32_t)host_b[k][c];
            }
        }
    }

    printf("[2] Configuring GEMM DMA Controller via AXI4-Lite...\n");
    gemm_regs[REG_SRC_A] = (uint32_t)MATRIX_A_PHYS;
    gemm_regs[REG_SRC_B] = (uint32_t)MATRIX_B_PHYS;
    gemm_regs[REG_DST_C] = (uint32_t)MATRIX_C_PHYS;

    printf("    SRC_ADDR_A: 0x%08X\n", gemm_regs[REG_SRC_A]);
    printf("    SRC_ADDR_B: 0x%08X\n", gemm_regs[REG_SRC_B]);
    printf("    DST_ADDR_C: 0x%08X\n", gemm_regs[REG_DST_C]);

    printf("[3] Triggering GEMM DMA Acceleration...\n");
    struct timespec t_start, t_end;
    clock_gettime(CLOCK_MONOTONIC, &t_start);

    // Assert START
    gemm_regs[REG_CTRL] = 0x00000001;

    // Poll DONE bit
    uint32_t status = 0;
    uint32_t timeout = 1000000;
    while (timeout--) {
        status = gemm_regs[REG_STATUS];
        if (status & 0x02) // Bit 1: DONE
            break;
    }
    clock_gettime(CLOCK_MONOTONIC, &t_end);

    if (timeout == 0) {
        printf("ERROR: GEMM DMA Timed out! Status: 0x%08X\n", status);
        close(fd);
        return 1;
    }

    uint32_t hw_cycles = gemm_regs[REG_CYCLE_CNT];
    double hw_time_us = (double)hw_cycles / CLOCK_FREQ_MHZ;
    double sw_time_us = (t_end.tv_sec - t_start.tv_sec) * 1e6 + (t_end.tv_nsec - t_start.tv_nsec) / 1e3;

    printf("[4] Hardware Execution Finished!\n");
    printf("    Hardware Cycles:   %u cycles\n", hw_cycles);
    printf("    Hardware Time:     %.2f us (@ 50 MHz)\n", hw_time_us);
    printf("    End-to-End Time:   %.2f us (including Linux polling)\n", sw_time_us);

    // Throughput: 16x16x16 multiply-accumulates = 2 * 16^3 = 8192 ops
    double ops = 2.0 * DIM * DIM * DIM;
    double gops = (ops / (hw_time_us * 1e-6)) / 1e9;
    printf("    Throughput:        %.2f GOPS\n", gops);

    printf("[5] Verifying computed Matrix C in DDR against Golden Model...\n");
    int errors = 0;
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            int32_t hw_val = mat_c[r * DIM + c];
            if (hw_val != golden_c[r][c]) {
                if (errors < 10) {
                    printf("    Mismatch at [%d][%d]: HW=%d, Expected=%d\n", r, c, hw_val, golden_c[r][c]);
                }
                errors++;
            }
        }
    }

    if (errors == 0) {
        printf("\n>>> VERIFICATION SUCCESS: All 256 matrix cells match 100%%! <<<\n");
    } else {
        printf("\n>>> VERIFICATION FAILED: %d errors detected! <<<\n", errors);
    }

    // Print sample 4x4 submatrix
    printf("\nSample 4x4 Output (Row 0..3, Col 0..3):\n");
    for (int r = 0; r < 4; r++) {
        printf("  [ ");
        for (int c = 0; c < 4; c++) {
            printf("%6d ", mat_c[r * DIM + c]);
        }
        printf("]\n");
    }

    close(fd);
    return (errors == 0) ? 0 : 1;
}
