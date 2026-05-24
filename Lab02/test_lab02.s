// =============================================================================
// CS 271 Computer Architecture - Lab 02: Instruction Encoding
// Purdue University Fort Wayne
// =============================================================================

    .text
    .global _start

_start:
    MOVZ    X5, #0xffff
    MOVK    X5, #0x00ff, LSL #16
    AND     X6, X5, #0x00003ffc00003ffc
    ORR     X7, X5, #0x00003ffc00003ffc
    YIELD
