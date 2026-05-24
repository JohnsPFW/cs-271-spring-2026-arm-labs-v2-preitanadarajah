// CS 271 Computer Architecture - Lab 01: Counted Loop
// Purdue University Fort Wayne

.text
.global _start

_start:
    MOVZ    X0, #5          // X0 = loop counter (5)
    MOVZ    X1, #1          // X1 = constant 1 (for register-form add/sub)
    MOVZ    X4, #0          // X4 = running sum
    MOVZ    X5, #0          // X5 = iteration count

sum_loop:
    ADD     X4, X4, X0      // Add counter into running sum
    ADD     X5, X5, X1      // Increment iteration count
    SUBS    X0, X0, X1      // Decrement counter and set flags
    B.NE    sum_loop        // Loop again while X0 != 0

done:
    YIELD
