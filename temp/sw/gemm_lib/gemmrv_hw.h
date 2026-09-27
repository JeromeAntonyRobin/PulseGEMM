#ifndef GEMMRV_HW_H
#define GEMMRV_HW_H

#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define HW_TILE_SIZE        16

// Physical addresses for PolarFire SoC Discovery Kit
#define PAGE_SIZE           0x1000
#define GEMM_REG_BASE_PHYS  0x60020000 
#define DDR_BASE_PHYS       0x88000000
#define MATRIX_A_PHYS       (DDR_BASE_PHYS + 0x0000)
#define MATRIX_B_PHYS       (DDR_BASE_PHYS + 0x1000)
#define MATRIX_C_PHYS       (DDR_BASE_PHYS + 0x2000)

// Register map offsets
#define REG_CTRL            (0x00 / 4)
#define REG_STATUS          (0x04 / 4)
#define REG_SRC_A           (0x08 / 4)
#define REG_SRC_B           (0x0C / 4)
#define REG_DST_C           (0x10 / 4)
#define REG_CYCLE_CNT       (0x14 / 4)

// Matrix struct
typedef struct {
    const int8_t* data;  // Flat row-major array
    int rows;            // True number of rows (M or K)
    int cols;            // True number of cols (K or N)
    int stride;          // Row stride (elements per row)
} gemmrv_mat;

// Output matrix (32-bit accumulation)
typedef struct {
    int32_t* data;
    int rows;
    int cols;
    int stride;
} gemmrv_mat_out;

#define GEMMRV_MAT(ptr, r, c, s) ((gemmrv_mat){ .data = (ptr), .rows = (r), .cols = (c), .stride = (s) })
#define GEMMRV_MAT_OUT(ptr, r, c, s) ((gemmrv_mat_out){ .data = (ptr), .rows = (r), .cols = (c), .stride = (s) })

// Hardware driver initialization & cleanup
int gemmrv_init(void);
void gemmrv_close(void);

// Reset & read hardware cycle counters
void hw_reset_perf_counters(void);
uint32_t hw_get_perf_cycles(void);

// Hardware-tiled matrix multiplication: C = A * B
// Supports arbitrary M, K, N (tiled automatically into 16x16 blocks with bounds zero-padding)
void gemmrv_mult(const gemmrv_mat* A, const gemmrv_mat* B, gemmrv_mat_out* C);

// CPU Software post-processing (Bias, ReLU, Scaling/Shift)
void gemmrv_post_process(gemmrv_mat_out* C, const int32_t* bias, int shift, int enable_relu);

#endif // GEMMRV_HW_H
