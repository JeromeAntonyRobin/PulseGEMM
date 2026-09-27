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

def test_config(mod_a, mod_b, name):
    C = [[sum(mod_a(r,k) * mod_b(k,c) for k in range(16)) for c in range(16)] for r in range(16)]
    match = True
    for c in range(0, 10):
        if C[0][c] != hw_r0[c]:
            match = False
            break
    if match:
        print(f"MATCH FOUND: {name}")

test_config(lambda r,k: host_a[r][k & ~2], lambda k,c: host_b[k][c & ~2], "Both byte 2->0, 3->1")
test_config(lambda r,k: host_a[r][k], lambda k,c: host_b[k][c & ~2], "B byte 2->0, 3->1")
test_config(lambda r,k: host_a[r][k & ~2], lambda k,c: host_b[k][c], "A byte 2->0, 3->1")

# What if it's 16-bit halfword swapped?
test_config(lambda r,k: host_a[r][k ^ 2], lambda k,c: host_b[k][c ^ 2], "Both bytes swapped 0<->2, 1<->3")

