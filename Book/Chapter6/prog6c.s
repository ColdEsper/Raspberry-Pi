	.global _start
_start:
	mov R1, #20
	mov R2, #5
	mul R0, R1, R2
	
mov R7, #1
	swi 0
