.text
.global mod

/* args:
	R0 unsigned value being divided, remainder should be in here at end
	R1 unsigned divisor, assumed to be greater than 1 */
mod:
	mov R2, R1
	cmp R1, R0
	bgt end
	b mod_start
/*bit shift left*/
modLoop:
	cmp R1, R0
	bhi result
mod_start:
	sub R0, R0, R1
	lsl R1, #1
	b modLoop
/*subtract and bit shift right*/
result:
	lsr R1, #1
	cmp R1, R2
	blo end
	cmp R1, R0
	bhi result
	sub R0, R0, R1
	b result
end:
	bx LR
