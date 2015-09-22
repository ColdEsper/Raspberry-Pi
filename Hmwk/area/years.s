	.global _start
_start:
	mov R2, #0b10101 @years bp -8 1 byte   1year/12months approximately 21/256
	mov R1, #0b001011000 @88 months bp 0 3 bytes
	mul R0, R1, R2
	lsr R0, R0, #8
	
	mov R7, #1
	swi 0

