host_a = [[(r * 3 - c * 2) % 15 for c in range(16)] for r in range(16)]
host_b = [[2 if r == c else ((r + c) % 5) - 2 for c in range(16)] for r in range(16)]
def c_mod(a, b):
    res = a % b
    return res if res * a >= 0 else res - b
for r in range(16):
    for c in range(16):
        val = c_mod(r * 3 - c * 2, 15)
        if val > 127: val -= 256
        if val < -128: val += 256
        host_a[r][c] = val
        val = 2 if r == c else c_mod(r + c, 5) - 2
        if val > 127: val -= 256
        if val < -128: val += 256
        host_b[r][c] = val

hw_r0 = [6, 2, 6, 2, -30, -2, -30, -2, -11, -28, -11, -28, 0, 0, 0, 0] # partial

print("HW:", hw_r0[:10])

C = [[sum(host_a[0][k] * host_b[k][c & ~2] for k in range(16)) for c in range(16)]]
print("B byte 2->0:", C[0][:10])

C = [[sum(host_a[0][k & ~2] * host_b[k][c] for k in range(16)) for c in range(16)]]
print("A byte 2->0:", C[0][:10])

C = [[sum(host_a[0][k & ~2] * host_b[k][c & ~2] for k in range(16)) for c in range(16)]]
print("Both byte 2->0:", C[0][:10])
