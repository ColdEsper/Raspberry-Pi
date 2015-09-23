	.global _start
_start:
	movw R2, #0x1C   @ divisor
	movw R1, #0xEDED @ value being divided
	movw R0, #0xFFFF @ remainder
_mod:
	mov R0, R1
	subs R1 ,R1, R2
	bge _mod

	mov R7, #1
	swi 0
