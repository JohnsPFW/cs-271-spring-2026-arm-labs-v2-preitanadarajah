// =============================================================================
// CS 271 Computer Architecture - Lab 04: Pipeline Hazards
// Purdue University Fort Wayne
// =============================================================================
// STUDENT NAME: Preita Nadarajah
// DATE:
// =============================================================================

    .text
    .global _start

_start:
    // PART 1: Independent Instructions (No Hazards)
    MOVZ    X0, #0xf
    MOVZ    X1, #0xe
    MOVZ    X2, #0xd
    MOVZ    X3, #0xc
    MOVZ    X4, #0xb

    // PART 2: Simple Dependencies
    ADD     X5, X0, #1
    ADD     X6, X1, X2
    SUBS    X7, X0, X1

    // PART 3: RAW Hazard with three NOPs (Part C)
_test2:
    ADD     X9, X1, X2          // X9 = X1 + X2 = 27
    NOP                         // first NOP command
    NOP                         // second NOP command
    NOP                         // third NOP command
    AND     X10, X9, X3         // X10 = X9 AND X3
    ORR     X11, X5, X9         // X11 = X5 OR X9
    SUB     X12, X9, X7         // X12 = X9 - X7

    // PART 4: Trailing NOPs
    NOP
    NOP
    NOP
    NOP

    YIELD
