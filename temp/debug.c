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
    printf("Golden Row 0:\n");
    for(int i=0; i<16; i++) printf("%d ", golden_c[0][i]);
    printf("\n");
    printf("Golden Row 1:\n");
    for(int i=0; i<16; i++) printf("%d ", golden_c[1][i]);
    printf("\n");
    printf("Golden Row 2:\n");
    for(int i=0; i<16; i++) printf("%d ", golden_c[2][i]);
    printf("\n");
    printf("Golden Row 3:\n");
    for(int i=0; i<16; i++) printf("%d ", golden_c[3][i]);
    printf("\n");
    return 0;
}
