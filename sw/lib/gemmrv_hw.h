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

// Register map offsets
#define REG_CTRL            (0x00 / 4)
#define REG_STATUS          (0x04 / 4)
#define REG_SRC_A           (0x08 / 4)
#define REG_SRC_B           (0x0C / 4)
#define REG_DST_C           (0x10 / 4)

// Read-only Perf Counters
#define REG_READ_PERF_FETCH_A    (0x14 / 4)
#define REG_READ_PERF_FETCH_B    (0x18 / 4)
#define REG_READ_PERF_COMPUTE    (0x1C / 4)
#define REG_READ_PERF_STORE_C    (0x20 / 4)

// Write-only Configuration
#define REG_WRITE_STRIDE_A       (0x14 / 4)
#define REG_WRITE_STRIDE_B       (0x18 / 4)
#define REG_WRITE_STRIDE_C       (0x1C / 4)
#define REG_WRITE_BOUNDS         (0x20 / 4)
#define REG_WRITE_TILE_N_COUNT   (0x24 / 4)

// Matrix struct
typedef struct {
    const int8_t* data;  // Pointer in mapped DDR space
    int rows;            // True number of rows (M or K)
    int cols;            // True number of cols (K or N)
    int stride;          // Row stride in elements (bytes)
} gemmrv_mat;

// Output matrix (32-bit accumulation)
typedef struct {
    int32_t* data;
    int rows;
    int cols;
    int stride;          // Row stride in 32-bit elements
} gemmrv_mat_out;

#define GEMMRV_MAT(ptr, r, c, s) ((gemmrv_mat){ .data = (ptr), .rows = (r), .cols = (c), .stride = (s) })
#define GEMMRV_MAT_OUT(ptr, r, c, s) ((gemmrv_mat_out){ .data = (ptr), .rows = (r), .cols = (c), .stride = (s) })

// Hardware driver initialization & cleanup
int gemmrv_init(void);
void gemmrv_close(void);
uint8_t *gemmrv_get_ddr_base(void);

// Control Register Bits
#define REG_CTRL_START           (1 << 0)
#define REG_CTRL_CLEAR_ACC       (1 << 1)
#define REG_CTRL_STORE_C         (1 << 2)
#define REG_CTRL_RESET_PERF      (1 << 3)
#define REG_CTRL_SOFT_RESET      (1 << 4)

// Reset & read hardware cycle counters
void hw_soft_reset(void);
void hw_reset_perf_counters(void);
void hw_read_perf_breakdown(uint32_t out[4]);
uint32_t hw_get_perf_cycles(void);

// Hardware-tiled matrix multiplication: C = A * B
// Pure hardware 2D strided DMA offload with zero CPU repacking
void gemmrv_mult(const gemmrv_mat* A, const gemmrv_mat* B, gemmrv_mat_out* C);

// CPU Software post-processing (Bias, ReLU, Scaling/Shift)
void gemmrv_post_process(gemmrv_mat_out* C, const int32_t* bias, int shift, int enable_relu);

#endif // GEMMRV_HW_H
