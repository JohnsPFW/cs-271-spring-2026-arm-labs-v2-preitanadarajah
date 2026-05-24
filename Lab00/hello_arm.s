// Lab 0: Toolchain Verification
// CS 271 - Spring 2026

.text
.global _start

_start:
    MOV X0, #10         // X0 = 10
    MOV X1, #5          // X1 = 5
    ADD X2, X0, X1      // X2 = 10 + 5 = 15

    MOV X3, #25         // X3 = 25
    ADD X4, X2, X3      // X4 = 15 + 25 = 40
    SUB X5, X0, X1      // X5 = 10 - 5 = 5

    MOV X6, #100        // X6 = 100

    YIELD               // End program
