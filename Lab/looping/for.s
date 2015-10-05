	.global _start
_start:
	/*for (i = 0;*/
	mov R1, #0 @counter
_sum:
	/*i<= 10*/
	cmp R1, #10
	bgt _end
	add R0, R0, R1
	/*++i)*/
	add R1, R1, #1
	b _sum
_end:
	mov R7, #1
	swi 0
