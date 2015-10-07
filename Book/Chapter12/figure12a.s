/* long multiplication - the hard way */
	.global _start
_start:
	movs R4, R1, lsr #16 @ R4 is ms 16 bits of R1
	bic R1, R1, R4, lsl #16 @ R1 is ls 16 bits
	mov R5, R2, lsr #16 @ R5 is ms 16 bits of R2
	bic R2, R2, R5, lsl #16 @R2 is ls 16 bits
	mul R3, R1, R2 @ Low partial product
	mul R2, R4, R2 @ 1st middle partial product
	mul R1, R5, R1 @ 2nd middle partial product
	mulne R4, R5, R4 @ High partial product - NE
	adds R1, R1, R2 @ Add mid partial products
	addcs R4, R4, #0x10000 @ Add carry to high partial
				@ product
	adds R3, R3, R1, lsl #16 @ Add middle partial product
	adc R4, R4, R1, lsr #16 @ sum into lo and hi words

	mov R7, #1
	swi 0
