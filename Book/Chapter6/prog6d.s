	.global _start
_start:
	mov R1, #20
	mov R2, #5
	mov R3, #10
	mla R0, R1, R2, R3

	mov R7, #1
	swi 0
