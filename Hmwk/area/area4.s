	.global _start
_start:
	movw R1, #0b0110010010010010 @ lower half bp -13 3 bytes approximately pi 
	/*movt R1, #0b0110010010010010 @ top half bp -13 3 bytes approximately pi */
	mov R2, #0b110 @ bp 0 1 byte radius of 6
	mul R3, R2, R2
	mul R0, R1, R3
	lsr R0, R0, #13

	mov R7, #1
	swi 0
