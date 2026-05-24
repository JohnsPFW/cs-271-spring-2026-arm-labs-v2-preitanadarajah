# Lab 02 Answers
**Student Name:** Preita Nadarajah

---

## How to decode an instruction encoding

**Worked Example: `MOVZ X1, #1` (encoding: `d2800021`)**

```
d    2    8    0    0    0    2    1
1101 0010 1000 0000 0000 0000 0010 0001
```

| 31 | 30-29 | 28-23  | 22-21 | 20-5             | 4-0   |
|----|-------|--------|-------|------------------|-------|
| sf | 10    | 100101 | hw    | imm16            | Rd    |
| 1  | 10    | 100101 | 00    | 0000000000000001 | 00001 |

- `sf` = 1 → 64-bit register
- `hw` = 00 → no shift
- `imm16` = 1
- `Rd` = 00001 = X1

---

## Section 3.2 — Interpreting Instruction Encodings

**1. `MOVZ X0, #5`**

Hex encoding: `0xd28000a0`

Binary:
```
d    2    8    0    0    0    a    0
1101 0010 1000 0000 0000 0000 1010 0000
```

| 31 | 30-29 | 28-23  | 22-21 | 20-5             | 4-0   |
|----|-------|--------|-------|------------------|-------|
| 1  | 10    | 100101 | 00    | 0000000000000101 | 00000 |

- `sf` = 1 (64-bit register)
- `hw` = 00 (LSL #0)
- `imm16` = 0000000000000101 (= 5)
- `Rd` = 00000 (X0)

---

**2. `ADD X4, X4, X0`**

Hex encoding: `0x8b000084`

Binary:
```
8    b    0    0    0    0    8    4
1000 1011 0000 0000 0000 0000 1000 0100
```

| 31 | 30 | 29 | 28-24 | 23-22 | 20-16 | 15-10  | 9-5   | 4-0   |
|----|----|----|-------|-------|-------|--------|-------|-------|
| 1  | 0  | 0  | 01011 | 00    | 00000 | 000000 | 00100 | 00100 |

- `Rm` = 00000 (X0)
- `Rn` = 00100 (X4)
- `Rd` = 00100 (X4)

---

**3. `SUBS X0, X0, X1`**

Hex encoding: `0xeb010000`

Binary:
```
e    b    0    1    0    0    0    0
1110 1011 0000 0001 0000 0000 0000 0000
```

| 31 | 30 | 29 | 28-24 | 23-22 | 20-16 | 15-10  | 9-5   | 4-0   |
|----|----|----|-------|-------|-------|--------|-------|-------|
| 1  | 1  | 1  | 01011 | 00    | 00001 | 000000 | 00000 | 00000 |

Comparison with ADD: in ADD, `op` = 0 and `S` = 0. In SUBS, `op` = 1 (subtract instead of add) and `S` = 1 (set condition flags). The `S` bit flipping from 0 to 1 is what signals that NZCV flags must be updated.

---

**4. `B.NE sum_loop`**

Hex encoding: `0x54ffffa1`

Binary:
```
5    4    f    f    f    f    a    1
0101 0100 1111 1111 1111 1111 1010 0001
```

| 31-24    | 23-5                | 4 | 3-0  |
|----------|---------------------|---|------|
| 01010100 | 1111111111111111101 | 0 | 0001 |

- `imm19` (binary) = 1111111111111111101
- `imm19` as two's complement integer = -3
- Byte offset (imm19 × 4) = -12
- `B.NE` address = 0x1c
- `sum_loop` address = 0x10
- Do they match? Yes: 0x1c + (-12) = 0x10 ✓

---

## Section 4.1 — Logical Immediate Values

Trace through the instructions:
- `MOVZ X5, #0xffff` → writes 0xFFFF into slot 0 (bits 15-0) and zeros all other slots. X5 = 0x000000000000FFFF
- `MOVK X5, #0x00ff, LSL #16` → writes 0x00FF into slot 1 (bits 31-16) while keeping all other bits unchanged. X5 = 0x0000000000FFFFFF

**X5** (after `MOVZ` + `MOVK`):
`X5 = 0x0000000000FFFFFF`

**X6** (after `AND X6, X5, #0x00003ffc00003ffc`):
`X6 = 0x0000000000003FFC`

**X7** (after `ORR X7, X5, #0x00003ffc00003ffc`):
`X7 = 0x00003FFC00FFFFFF`

---

## Section 5 — Instruction Aliases

- Base instruction: `SUBS`
- Full expanded form: `SUBS XZR, X0, X1` — the subtraction result is discarded into the zero register (XZR), but the NZCV condition flags are still set, which is exactly what makes `CMP` useful before a conditional branch like B.NE or B.EQ.
