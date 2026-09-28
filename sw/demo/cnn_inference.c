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

#define HW_DIM              16
#define LARGE_DIM           64
#define CLOCK_FREQ_MHZ      100.0 // Adjusted based on empirical timing

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

    // Allocate 64x64 matrices for the "CNN Fully Connected Layer"
    int8_t (*host_a)[LARGE_DIM] = malloc(LARGE_DIM * LARGE_DIM * sizeof(int8_t));
    int8_t (*host_b)[LARGE_DIM] = malloc(LARGE_DIM * LARGE_DIM * sizeof(int8_t));
    int32_t (*sw_c)[LARGE_DIM] = malloc(LARGE_DIM * LARGE_DIM * sizeof(int32_t));
    int32_t (*hw_c)[LARGE_DIM] = malloc(LARGE_DIM * LARGE_DIM * sizeof(int32_t));

    // Initialize with mock weights and activations
    for (int r = 0; r < LARGE_DIM; r++) {
        for (int c = 0; c < LARGE_DIM; c++) {
            host_a[r][c] = (int8_t)((r * 7 - c * 3) % 15);
            host_b[r][c] = (int8_t)(((r + c) % 11) - 5);
        }
    }

    struct timespec sw_start, sw_end;
    printf("[*] Running 64x64 Software Inference (Baseline)...\n");
    clock_gettime(CLOCK_MONOTONIC, &sw_start);
    
    // SW Compute
    for (int r = 0; r < LARGE_DIM; r++) {
        for (int c = 0; c < LARGE_DIM; c++) {
            int32_t acc = 0;
            for (int k = 0; k < LARGE_DIM; k++) {
                acc += (int32_t)host_a[r][k] * (int32_t)host_b[k][c];
            }
            sw_c[r][c] = acc;
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &sw_end);
    double sw_time_us = get_time_us(&sw_start, &sw_end);

    printf("[*] Running 64x64 Hardware Tiled Inference...\n");
    
    gemm_regs[REG_SRC_A] = (uint32_t)MATRIX_A_PHYS;
    gemm_regs[REG_SRC_B] = (uint32_t)MATRIX_B_PHYS;
    gemm_regs[REG_DST_C] = (uint32_t)MATRIX_C_PHYS;

    struct timespec hw_start, hw_end;
    clock_gettime(CLOCK_MONOTONIC, &hw_start);
    
    uint32_t total_hw_cycles = 0;
    int hw_invocations = 0;

    // Tiling logic: Break 64x64 into a 4x4 grid of 16x16 tiles
    for (int i = 0; i < LARGE_DIM / HW_DIM; i++) {
        for (int j = 0; j < LARGE_DIM / HW_DIM; j++) {
            int32_t c_acc[HW_DIM][HW_DIM] = {0};
            
            // Dot product along K dimension
            for (int k = 0; k < LARGE_DIM / HW_DIM; k++) {
                // Pack 16x16 tile of A
                for (int r = 0; r < HW_DIM; r++) {
                    for (int c = 0; c < HW_DIM; c += 4) {
                        int row = i * HW_DIM + r;
                        int col = k * HW_DIM + c;
                        uint32_t word = ((uint8_t)host_a[row][col]) | 
                                        (((uint8_t)host_a[row][col+1]) << 8) | 
                                        (((uint8_t)host_a[row][col+2]) << 16) | 
                                        (((uint8_t)host_a[row][col+3]) << 24);
                        mat_a[(r * HW_DIM + c) / 4] = (uint64_t)word;
                    }
                }
                
                // Pack 16x16 tile of B
                for (int r = 0; r < HW_DIM; r++) {
                    for (int c = 0; c < HW_DIM; c += 4) {
                        int row = k * HW_DIM + r;
                        int col = j * HW_DIM + c;
                        uint32_t word = ((uint8_t)host_b[row][col]) | 
                                        (((uint8_t)host_b[row][col+1]) << 8) | 
                                        (((uint8_t)host_b[row][col+2]) << 16) | 
                                        (((uint8_t)host_b[row][col+3]) << 24);
                        mat_b[(r * HW_DIM + c) / 4] = (uint64_t)word;
                    }
                }

                // Run Accelerator
                gemm_regs[REG_CTRL] = 0x00000001;
                while (!(gemm_regs[REG_STATUS] & 0x02));
                
                total_hw_cycles += gemm_regs[REG_CYCLE_CNT];
                hw_invocations++;

                // Accumulate results from hardware DDR buffer
                for (int r = 0; r < HW_DIM; r++) {
                    for (int c = 0; c < HW_DIM; c++) {
                        c_acc[r][c] += (int32_t)mat_c[r * HW_DIM + c];
                    }
                }
            }
            
            // Store final accumulated 16x16 tile into the 64x64 output
            for (int r = 0; r < HW_DIM; r++) {
                for (int c = 0; c < HW_DIM; c++) {
                    hw_c[i * HW_DIM + r][j * HW_DIM + c] = c_acc[r][c];
                }
            }
        }
    }
    
    clock_gettime(CLOCK_MONOTONIC, &hw_end);
    double hw_time_cpu_us = get_time_us(&hw_start, &hw_end);
    
    // Verify
    int errors = 0;
    for (int r = 0; r < LARGE_DIM; r++) {
        for (int c = 0; c < LARGE_DIM; c++) {
            if (sw_c[r][c] != hw_c[r][c]) errors++;
        }
    }

    printf("============================================================\n");
    printf("             CNN LAYER (64x64) BENCHMARK RESULTS\n");
    printf("============================================================\n");
    printf("Verification      : %d Errors\n", errors);
    printf("Operations        : %d MACs\n", LARGE_DIM * LARGE_DIM * LARGE_DIM);
    printf("HW Invocations    : %d (16x16 tiles)\n\n", hw_invocations);
    
    printf("SW Compute Time   : %.3f us\n", sw_time_us);
    printf("HW System Time    : %.3f us (Includes CPU tiling & packing overhead)\n", hw_time_cpu_us);
    
    double exact_ip_time = (double)total_hw_cycles / CLOCK_FREQ_MHZ;
    printf("HW Pure IP Time   : %.3f us (%u total cycles @ %.1f MHz)\n\n", exact_ip_time, total_hw_cycles, CLOCK_FREQ_MHZ);
           
    printf("END-TO-END SPEEDUP (SW vs HW System) : %.2f x\n", sw_time_us / hw_time_cpu_us);
    printf("THEORETICAL SPEEDUP (SW vs HW IP)    : %.2f x\n", sw_time_us / exact_ip_time);
    printf("============================================================\n");

    free(host_a);
    free(host_b);
    free(sw_c);
    free(hw_c);
    close(fd);
    return 0;
}
