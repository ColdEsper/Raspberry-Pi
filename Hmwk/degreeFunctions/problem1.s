.data
.balign 4
beg: .word 0
.balign 4
end: .word 0
.balign 4
return: .word 0
.text
	.global problem1

/*Celsius to Fahrenheit*/
problem1:
	/*save passed in args */
	ldr R2, [R2]
	ldr R4, =beg
	str R2, [R4]
	ldr R3, [R3]
	ldr R4, =end
	str R3, [R4]
	/*save address of return */
	ldr R1, address_of_return
	str LR, [R1]

	/*print msg*/
	ldr R0, =display_msg
	bl printf
	ldr R1, =beg
	ldr R1, [R1]
	ldr R5, =end
	ldr R4, [R5]
	add R4, #1
	str R4, [R5]
	b convertCtoFStart
convertCtoF:
	ldr R1, =beg
	ldr R1, [R1]
	ldr R4, =end
	ldr R4, [R4]
convertCtoFStart:
	cmp R1, R4
	beq endConvertCtoF
	ldr R5, =nineFifths
	ldr R5, [R5]
	/* R1=R1*integer((9/5)>>16)*/
	mul R1, R5
	/*Scales down R1 from bp 16 to bp 0 since nineFifths was at bp 16*/
	lsr R1, #16
	add R1, #32
	/*print conversion*/
	ldr R0, =printFormat2
	bl printf
	/*print celsius */
	ldr R1, =beg
	ldr R1, [R1]
	ldr R0, =printFormat
	bl printf
	/*increment counter (beg)*/
	ldr R6, =beg
	ldr R3, [R6]
	add R3, #1
	str R3, [R6]
	b convertCtoF
endConvertCtoF:

	/*return */
	ldr R1, address_of_return
	ldr LR, [R1]
	bx LR

address_of_return: .word return
/* 9.0/5.0 at binary point 16 */
nineFifths: .word 0x1cccd
