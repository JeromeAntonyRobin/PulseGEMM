#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define PAGE_SIZE 0x1000
#define GEMM_REG_BASE_PHYS 0x60020000 
#define DDR_BASE_PHYS 0x88000000

int main() {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) { perror("open"); return 1; }

    volatile uint32_t *regs = (volatile uint32_t *)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, GEMM_REG_BASE_PHYS);
    volatile uint8_t *ddr = (volatile uint8_t *)mmap(NULL, 1024*1024, PROT_READ | PROT_WRITE, MAP_SHARED, fd, DDR_BASE_PHYS);

    printf("Initial REG_STATUS: 0x%08X\n", regs[1]);

    // Issue soft-reset and reset perf counters
    regs[0] = 0x18; // soft_reset (bit 4) | reset_perf (bit 3)
    usleep(100);
    printf("Post-reset REG_STATUS: 0x%08X\n", regs[1]);

    // Setup a 16x16 test tile
    // Matrix A at offset 0x0000
    // Matrix B at offset 0x1000
    // Matrix C at offset 0x2000
    // Initialize A (16x160) and B (160x112) with 1
    for(int i=0; i<16*160; i++) ddr[0x0000 + i] = 1;
    for(int i=0; i<160*112; i++) ddr[0x10000 + i] = 1; // place B at 64KB offset
    for(int i=0; i<16*112*4; i++) ddr[0x30000 + i] = 0; // place C at 192KB offset

    printf("\n--- Testing Exact Conv2 Tile (M=16, K=160, N=16, Strides: A=160, B=112, C=112) ---\n");
    regs[0] = 0x18; // soft reset + reset perf
    usleep(100);

    regs[2] = 0x88000000; // SRC_A
    regs[3] = 0x88010000; // SRC_B
    regs[4] = 0x88030000; // DST_C
    regs[5] = 160;        // STRIDE_A
    regs[6] = 112;        // STRIDE_B
    regs[7] = 112;        // STRIDE_C
    regs[8] = (16 << 24) | (16 << 16) | 160; // BOUNDS: N=16, M=16, K=160
    regs[9] = 1;          // TILE_N_COUNT = 1

    regs[0] = 0x07; // start=1, clear=1, store=1

    int timeout = 0;
    while ((regs[1] & 0x05) != 0x04) {
        timeout++;
        if (timeout > 2000000) {
            printf("TIMEOUT! REG_STATUS: 0x%08X, CTRL: 0x%08X\n", regs[1], regs[0]);
            printf("Perf Fetch A: %u, Fetch B: %u, Compute: %u, Store C: %u\n",
                   regs[5], regs[6], regs[7], regs[8]);
            regs[0] = 0x10; // soft reset
            break;
        }
    }

    if ((regs[1] & 0x05) == 0x04) {
        printf("SUCCESS! Perf: Fetch A: %u, Fetch B: %u, Compute: %u, Store C: %u\n",
               regs[5], regs[6], regs[7], regs[8]);
        volatile int32_t *c = (volatile int32_t *)(ddr + 0x30000);
        printf("Row 0: ");
        for (int i=0; i<16; i++) printf("%d ", c[i]);
        printf("\n");
        printf("Row 15: ");
        for (int i=0; i<16; i++) printf("%d ", c[15 * 112 + i]);
        printf("\n");
    }

    close(fd);
    return 0;
}
