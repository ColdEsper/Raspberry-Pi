	.global _start
_start:
	movw R5, #0x1C   @ divisor 28
	mov  R2, R5
	movw R1, #0xEC   @ value being divided 236, remainder should be in here at end
	movw R0, #0x0    @ counter at 0
	movw R3, #0x1    @ shifted increment = 2^(divisor bp)

	cmp R2, R1
	bgt _end
	b _div_start
/*subtraction and bit shift left*/
_div:
	cmp R2, R1
	bgt _result
_div_start:
	sub R1, R1, R2
	add R0, R3
	lsl R2, #1
	lsl R3, #1  @ shifts increment along with divisor a.k.a. multiply by 2
	b _div
/*subtract and bit shift right*/
_result:
	lsr R2, #1
	lsr R3, #1 @ shifts increment along with divisor a.k.a. divide by 2
	cmp R3, #0
	beq _end
	cmp R2, R1
	bgt _result
	sub R1, R1, R2
	add R0, R0, R3
	b _result
_end:
	mov R7, #1
	swi 0
