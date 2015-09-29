	.global _start
_start:
	movw R5, #0x1C   @ divisor 28
	mov  R2, R5
	movw R0, #0xEC   @ value being divided 236, remainder should be in here at end

	cmp R2, R0
	bgt _end
	b _mod_start
/*subtraction and bit shift left*/
_mod:
	cmp R2, R0
	bgt _result
_mod_start:
	sub R0, R0, R2
	lsl R2, #1
	b _mod
/*subtract and bit shift right*/
_result:
	lsr R2, #1
	cmp R2, R5
	bmi _end
	cmp R2, R0
	bgt _result
	sub R0, R0, R2
	b _result
_end:
	mov R7, #1
	swi 0
