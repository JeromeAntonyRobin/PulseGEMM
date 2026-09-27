#include <stdio.h>
#include <stdint.h>
int main() {
    int8_t host_a[16][16];
    int8_t host_b[16][16];
    int32_t golden_c[16][16];
    for (int r = 0; r < 16; r++) {
        for (int c = 0; c < 16; c++) {
            host_a[r][c] = (int8_t)((r * 3 - c * 2) % 15);
            host_b[r][c] = (r == c) ? (int8_t)2 : (int8_t)(((r + c) % 5) - 2);
        }
    }
    for (int r = 0; r < 16; r++) {
        for (int c = 0; c < 16; c++) {
            golden_c[r][c] = 0;
            for (int k = 0; k < 16; k++) {
                golden_c[r][c] += (int32_t)host_a[r][k] * (int32_t)host_b[k][c];
            }
        }
    }
    printf("A Row 0: "); for(int i=0; i<16; i++) printf("%4d ", host_a[0][i]); printf("\n");
    printf("B Col 0: "); for(int i=0; i<16; i++) printf("%4d ", host_b[i][0]); printf("\n");
    printf("C expected: %d\n", golden_c[0][0]);
    
    // Simulate what HW might be doing if it's reading B wrong
    int32_t hw_sim = 0;
    for(int k=0; k<16; k++) hw_sim += (int32_t)host_a[0][k] * (int32_t)host_b[0][k]; // What if B is transposed?
    printf("If B is transposed: %d\n", hw_sim);
    return 0;
}
