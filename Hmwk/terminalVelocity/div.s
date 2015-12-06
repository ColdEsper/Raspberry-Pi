	.global div
/* args:
        R0 unsigned value being divided, 
        R1 unsigned divisor, assumed to be greater than 1
   return:
        R0 result */
   
div:
	push {R1, R2, R3, R4}
	mov R2, R1  @ divisor
	mov R1, R0  @ value being divided
	movw R0, #0x0    @ counter at 0
	movw R3, #0x1    @ shifted increment = 2^(divisor bp)

	cmp R2, R1
	bgt _end
	b _div_start
/*bit shift left*/
_div:
	cmp R2, R1
	bgt _result
_div_start:
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
	pop {R1, R2, R3, R4}
	bx LR
