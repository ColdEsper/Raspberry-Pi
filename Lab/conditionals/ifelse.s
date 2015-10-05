	.global _start
_start:
	mov R1, #2
	/* default value of 0*/
	mov R0, #0

/*if else goes straight to end on first successful if*/
_monIf:
	cmp R1, #1
	bne _tuesIf
	mov R0, #11
	b _end
_tuesIf:
	cmp R1, #2
	bne _wedsIf
	mov R0, #5
	b _end
_wedsIf:
	cmp R1, #3
	bne _thursIf
	mov R0, #11
	b _end
_thursIf:
	cmp R1, #4
	bne _friIf
	mov R0, #5
	b _end
_friIf:
	cmp R1, #5
	bne _end
	mov R0, #1
	b _end
_end:
	mov R7, #1
	swi 0
