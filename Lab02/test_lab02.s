// =============================================================================
// CS 271 Computer Architecture - Lab 02: Post-Increment Addressing
// Purdue University Fort Wayne
// =============================================================================

    .text
    .global _start

_start:
    MOVZ    X0, #0x0050         // X0 = source pointer
    MOVZ    X1, #0x013C         // X1 = destination pointer

    MOVZ    X5, #0x65           // ASCII 'e'
    MOVZ    X6, #0x66           // ASCII 'f'
    STURB   W5, [X0]            // Store 'e' at 0x50
    STURB   W6, [X0, #1]        // Store 'f' at 0x51
    STURB   WZR, [X0, #2]       // Store null terminator at 0x52

_strcpyloop:
    LDRB    W2, [X0], #1        // Load byte, post-increment X0
    STRB    W2, [X1], #1        // Store byte, post-increment X1
    CMP     X2, #0              // Compare byte to zero
    BNE     _strcpyloop         // Loop if not zero

    YIELD
