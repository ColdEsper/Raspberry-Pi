	.global _start
_start:
	mov R1, #50
	mov R2, #60
	adds R0, R1, R2
	
	mov R7, #1
	swi 0
