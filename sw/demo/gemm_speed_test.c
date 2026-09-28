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

static inline double get_time_us(struct timespec *start, struct timespec *end) {
    return (end->tv_sec - start->tv_sec) * 1000000.0 + (end->tv_nsec - start->tv_nsec) / 1000.0;
}

int main(int argc, char **argv) {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("open");
        return 1;
    }

    volatile uint32_t *gemm_regs = (volatile uint32_t *)map_physical(fd, GEMM_REG_BASE_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_a = (volatile uint64_t *)map_physical(fd, MATRIX_A_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_b = (volatile uint64_t *)map_physical(fd, MATRIX_B_PHYS, PAGE_SIZE);
    volatile uint64_t *mat_c = (volatile uint64_t *)map_physical(fd, MATRIX_C_PHYS, PAGE_SIZE);

    int8_t host_a[DIM][DIM];
    int8_t host_b[DIM][DIM];
    int32_t golden_c[DIM][DIM];

    // Initialize matrices
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            host_a[r][c] = (int8_t)((r * 3 - c * 2) % 15);
            host_b[r][c] = (r == c) ? (int8_t)2 : (int8_t)(((r + c) % 5) - 2);
        }
    }

    struct timespec sw_start, sw_end;
    
    // RUN SOFTWARE BENCHMARK (multiple iterations to get stable time)
    int iterations = 1000;
    clock_gettime(CLOCK_MONOTONIC, &sw_start);
    for (int i = 0; i < iterations; i++) {
        for (int r = 0; r < DIM; r++) {
            for (int c = 0; c < DIM; c++) {
                int32_t acc = 0;
                for (int k = 0; k < DIM; k++) {
                    acc += (int32_t)host_a[r][k] * (int32_t)host_b[k][c];
                }
                golden_c[r][c] = acc;
            }
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &sw_end);
    double sw_time_us = get_time_us(&sw_start, &sw_end) / iterations;

    // Format data for hardware
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c += 4) {
            uint32_t word_a = ((uint8_t)host_a[r][c]) | (((uint8_t)host_a[r][c+1]) << 8) | (((uint8_t)host_a[r][c+2]) << 16) | (((uint8_t)host_a[r][c+3]) << 24);
            uint32_t word_b = ((uint8_t)host_b[r][c]) | (((uint8_t)host_b[r][c+1]) << 8) | (((uint8_t)host_b[r][c+2]) << 16) | (((uint8_t)host_b[r][c+3]) << 24);
            mat_a[(r * DIM + c) / 4] = (uint64_t)word_a;
            mat_b[(r * DIM + c) / 4] = (uint64_t)word_b;
        }
    }

    // Configure HW
    gemm_regs[REG_SRC_A] = (uint32_t)MATRIX_A_PHYS;
    gemm_regs[REG_SRC_B] = (uint32_t)MATRIX_B_PHYS;
    gemm_regs[REG_DST_C] = (uint32_t)MATRIX_C_PHYS;

    // RUN HARDWARE BENCHMARK
    struct timespec hw_start, hw_end;
    clock_gettime(CLOCK_MONOTONIC, &hw_start);
    
    gemm_regs[REG_CTRL] = 0x00000001;
    uint32_t status = 0;
    while (1) {
        status = gemm_regs[REG_STATUS];
        if (status & 0x02) break;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &hw_end);
    
    // The CPU time includes AXI latency and polling overhead
    double hw_time_cpu_us = get_time_us(&hw_start, &hw_end);
    
    // The precise HW IP time in cycles
    uint32_t hw_cycles = gemm_regs[REG_CYCLE_CNT];
    double hw_time_exact_us = (double)hw_cycles / CLOCK_FREQ_MHZ;

    // Verify
    int errors = 0;
    for (int r = 0; r < DIM; r++) {
        for (int c = 0; c < DIM; c++) {
            int32_t hw_val = (int32_t)mat_c[r * DIM + c];
            if (hw_val != golden_c[r][c]) errors++;
        }
    }

    printf("============================================================\n");
    printf("             SPEEDUP BENCHMARK RESULTS\n");
    printf("============================================================\n");
    printf("Verification: %d Errors\n\n", errors);
    
    printf("SW Compute Time (CPU %d iterations avg) : %.3f us\n", iterations, sw_time_us);
    printf("HW Compute Time (CPU polling overhead)    : %.3f us\n", hw_time_cpu_us);
    printf("HW Compute Time (Exact IP Cycle Count)    : %.3f us (%u cycles @ %.1f MHz)\n\n", 
           hw_time_exact_us, hw_cycles, CLOCK_FREQ_MHZ);
           
    printf("SPEEDUP (SW vs HW with overhead)          : %.2f x\n", sw_time_us / hw_time_cpu_us);
    printf("SPEEDUP (SW vs HW exact IP)               : %.2f x\n", sw_time_us / hw_time_exact_us);
    printf("============================================================\n");

    close(fd);
    return 0;
}
