	.global _start
_start:
	movw R1, #0b01100100 @ lower half bp -5 2 bytes approximately pi 
	mov R2, #0b1101 @ bp -1 1 byte radius of 6.5
	mul R3, R2, R2
	mul R0, R1, R3
	lsr R0, R0, #7

	mov R7, #1
	swi 0
