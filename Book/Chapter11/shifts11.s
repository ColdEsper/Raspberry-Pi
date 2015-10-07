	.global _start
_start:
	/* lsl */
	mov R1, #17
	movs R0, R1, lsl #1
	/* lsr */
	mov R1, #17
	movs R0, R1, lsr #1
	/* ror */
	mov R1, #0xF000000F
	movs R0, R1, ror #4
	/* rrx : Rotate Right with eXtend */
	mov R0, R1, RRX

	mov R7, #1
	swi 0
