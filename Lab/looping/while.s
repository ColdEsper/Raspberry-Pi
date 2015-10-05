	.global _start
_start:
	mov R1, #0 @counter
	/* while (R1 <= 10)*/
	cmp R1, #10
	bgt end
_sum:
	add R0, R0, R1
	add R1, R1, #1
	cmp R1, #10
	ble _sum
_end:
	mov R7, #1
	swi 0
