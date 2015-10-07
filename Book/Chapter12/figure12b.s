	.global _start
_start:
	mov R2, #3 @ non-zero divisor

	mov R4, R2 @ Put the divisor in R4.
	cmp R4, R1, lsr #1 @ Then double it until
			@ 2 x R4 > divisor
Div1:
	movls R4, R4, lsl #1
	cmp R4, R1, lsr #1
	bls Div1
	mov R3, #0 @ Initialise the quotient

Div2:
	cmp R1, R4 @ Can we subtract R4?
	subcs R1, R1, R4 @ If we can, do so
	adc R3, R3, R3 @ Double quotient &
		@add new bit
	mov R4, R4, lsr #1 @ Halve R4
	cmp R4, R2 @ Loop until we've gone
	bhs Div2 @ past the original divisor

	mov R7, #1
	swi 0
