.data
.balign 4
counter: .word 0
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
	ldr R3, =counter
	str R1, [R3]
	ldr R5, =end
	ldr R4, [R5]
	add R4, #1
	str R4, [R5]
	b convertCtoFStart
convertCtoF:
	ldr R1, =counter
	ldr R1, [R1]
	ldr R4, =end
	ldr R4, [R4]
convertCtoFStart:
	cmp R1, R4
	beq endConvertCtoF
	ldr R0, =printFormat2
	bl printf
	ldr R5, =nineFifths
	ldr R5, [R5]
	ldr R3, =counter
	ldr R3, [R3]
	mov R1, R3
	/* R1=R1*integer((9/5)>>16)*/
	mul R1, R5
	/*Scales down R1 from bp 16 to bp 0 since nineFifths was at bp 16*/
	lsr R1, #16
	add R1, #32
	/*increment counter R3*/
	add R3, #1
	ldr R6, =counter
	str R3, [R6]
	/*print conversion*/
	ldr R0, =printFormat
	bl printf
	b convertCtoF
endConvertCtoF:

	/*return */
	ldr R1, address_of_return
	ldr LR, [R1]
	bx LR

address_of_return: .word return
