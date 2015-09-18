	.global _start
_start:
	mov R2, #0xFFFFFFFF
	mov R3, #0x1
	mov R4, #0xFFFFFFFF
	mov R5, #0xFF
	adds R0, R2, R4
	adcs R1, R3, R5
	
	mov R7, #1
	swi 0
