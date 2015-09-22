	.global _start
_start:
	/*1/pi apprx 7/22 apprx */
	movw R1, #0b0111010001011101 @ lower half bp -23 3 bytes approximately 1/pi 
	movt R1, #0b0000000001010001 @ upper half bp -23 3 bytes approximately 1/pi 
	movw R2, #0b01101110  @ bp 0 110
	mul R0, R1, R2
	lsr R0, R0, #24

	mov R7, #1
	swi 0
