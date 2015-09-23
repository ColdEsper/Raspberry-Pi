	.global _start
_start:
	movw R1, #0b1001001001001001 @ lower half bp -21 3 bytes approximately pi 
	movt R1, #0b0000000001100100 @ top half bp -21 bytes approximately pi 
	mov R2, #0b110 @ bp 0 1 byte radius of 6
	mul R3, R2, R2
	mul R0, R1, R3
	lsr R0, R0, #21

	mov R7, #1
	swi 0
