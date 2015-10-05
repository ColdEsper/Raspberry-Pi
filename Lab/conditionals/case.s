	.global _start
_start:
	mov R1, #2
	/* default value of 0*/
	mov R0, #0

	cmp R1, #1
	beq _mon
	cmp R1, #2
	beq _tues
	cmp R1, #3
	beq _weds
	cmp R1, #4
	beq _thurs
	cmp R1, #5
	beq _fri
_mon:
	mov R0, #11
	/*break from case statement to prevent fall through*/
	b _end
_tues:
	mov R0, #5
	b _end
_weds:
	mov R0, #11
	b _end
_thurs:
	mov R0, #5
	b _end
_fri:
	mov R0, #1
	b _end
_end:
	mov R7, #1
	swi 0
