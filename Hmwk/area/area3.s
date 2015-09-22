	.global _start
_start:
	/*1/pi apprx 7/22 apprx */
	movw R1, #0b1010001011101 @ bp -13 3 bytes approximately 1/pi 
	movw R2, #0b011100010110011  @ bp -7 113.4
	mul R0, R1, R2
	lsr R0, R0, #21

	mov R7, #1
	swi 0
