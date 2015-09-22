	.global _start
_start:
	/*1/pi apprx 7/22 apprx */
	movw R1, #0b0101000101110100 @ bp -15 3 bytes approximately 1/pi 
	movw R2, #0b011100010110011  @ bp 0 113.4 bp -7
	mul R0, R1, R2
	lsr R0, R0, #23

	mov R7, #1
	swi 0
