	.global _start
_start:
	movw R2, #0x1C   @ divisor 28
	movw R1, #0xEC   @ value being divided 236
	movw R0, #0xFFFF @ counter at -1
_div:
	add R0, R0, #1   @ increment
	subs R1 ,R1, R2
	bge _div

	mov R7, #1
	swi 0
