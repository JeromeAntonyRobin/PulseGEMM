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

# HW Output row 0 (odd elements are 0 due to 8-bit write bug, so we ignore them)
hw_r0 = [15, 0, -7, 0, 15, 0, -7, 0, -11, 0, -5, 0, -11, 0, -5, 0]

def test_config(mod_a, mod_b, name):
    C = [[sum(mod_a(r,k) * mod_b(k,c) for k in range(16)) for c in range(16)] for r in range(16)]
    match = True
    for c in range(0, 16, 2):
        if C[0][c] != hw_r0[c]:
            match = False
            break
    if match:
        print(f"MATCH FOUND: {name}")

test_config(lambda r,c: host_a[r][c], lambda r,c: host_b[r][c], "Normal")
test_config(lambda r,c: host_a[c][r], lambda r,c: host_b[r][c], "A transposed")
test_config(lambda r,c: host_a[r][c], lambda r,c: host_b[c][r], "B transposed")
test_config(lambda r,c: host_a[c][r], lambda r,c: host_b[c][r], "A, B transposed")
test_config(lambda r,c: host_b[r][c], lambda r,c: host_a[r][c], "A, B swapped")

# Try indexing bugs:
# What if A was read with a bug where column index was masked?
for mask in [0, 1, 2, 3, 7, 15]:
    test_config(lambda r,c: host_a[r][c & mask], lambda r,c: host_b[r][c], f"A col masked & {mask}")
    test_config(lambda r,c: host_a[r][c], lambda r,c: host_b[r][c & mask], f"B col masked & {mask}")
    test_config(lambda r,c: host_a[r][c & mask], lambda r,c: host_b[r][c & mask], f"Both masked & {mask}")
