/**** Convert to binary for printing ****/

	.global _start
_start:
	mov R6, #15 @Number to print in R6
	mov R10, #1 @set up mask
	mov R9, R10, lsl #31
	ldr R1, = string @point R1 to string
_bits:
	tst R6, R9 @tst no, mask
	moveq R0, #48 @ASCII '0'
	movne R0, #49 @ASCII '1'
	str R0, [R1] @store 1 in string
	mov R8, R6 @mov preserve, no
	bl _write @write to screen
	mov R6, r8 @mov no, preserve
	movs R9, R9, lsr #1 @shuffle mask bits
	bne _bits
_exit:
	mov R7, #1
	swi 0
_write:
	mov R0, #1
	mov R2, #1
	mov R7, #4
	swi 0
	bx lr

.data
string: .ascii " "
