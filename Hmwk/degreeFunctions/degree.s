.data
.balign 4
display_msg: .asciz "Display Degree Centigrade to Degree Fahrenheit\nFahrenheit Centigrade\n"
.balign 4
input_msg: .asciz "Input beginning and end of temperature range.\n"
.balign 4
range_input_msg: .asciz "If range is degree Centigrade input 1\nIf range is degree Fahrenheiht input 2\nIf quitting desired input 3\n"
.balign 4
inputFormat: .asciz "%d"
.balign 4
printFormat: .asciz "         %d\n"
.balign 4
printFormat2: .asciz "%d "
.balign 4
start: .word 0
.balign 4
end: .word 0
.balign 4
choice: .word 0
.balign 4
counter: .word 0
/*fahrenheit and celsius at binary point 7 */
.balign 4
fahrenheit: .word 0
.balign 4
celsius: .word 0
return: .word 0 
.balign 4
return2: .word 0 

.text
	.global main
main:
	ldr R1, address_of_return
	str LR, [R1]

whileDo:
	ldr R0, =input_msg
	bl printf
	ldr R0, =inputFormat
	ldr R1, =start
	bl scanf
	ldr R0, =inputFormat
	ldr R1, =end
	bl scanf
convAsk:
	/* print msg */
	ldr R0, =range_input_msg
	bl printf
	/*get input*/
	ldr R0, =inputFormat
	ldr R1, =choice
	bl scanf
	ldr R1, =choice
	ldr R1, [R1]
	/* jump to conversion function, jump to quit, or repeat quesition */
	cmp R1, #1
	beq doOne
	cmp R1, #2
	beq doTwo
	cmp R1, #3
	beq endDo
	b convAsk
doOne:
	bl problemOne
	b whileDo
doTwo:
	bl problemTwo
	b whileDo
endDo:

	ldr R1, address_of_return
	ldr LR, [R1]
	bx LR

/*Celsius to Fahrenheit*/
problemOne:
	/*save address of return */
	ldr R1, address_of_return2
	str LR, [R1]

	/*print msg*/
	ldr R0, =display_msg
	bl printf
	ldr R1, =start
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
	ldr R1, address_of_return2
	ldr LR, [R1]
	bx LR

/*Fahrenheit to Celsius*/
problemTwo:
	/*save address of return */
	ldr R1, address_of_return2
	str LR, [R1]

	/*print msg*/
	ldr R0, =display_msg
	bl printf
	ldr R1, =start
	ldr R1, [R1]
	ldr R3, =counter
	str R1, [R3]
	ldr R5, =end
	ldr R4, [R5]
	add R4, #1
	str R4, [R5]
	b convertFtoCStart
convertFtoC:
	ldr R1, =counter
	ldr R1, [R1]
	ldr R4, =end
	ldr R4, [R4]
convertFtoCStart:
	cmp R1, R4
	beq endConvertFtoC
	ldr R0, =printFormat2
	bl printf
	ldr R5, =fiveNinths
	ldr R5, [R5]
	ldr R3, =counter
	ldr R3, [R3]
	mov R1, R3
	sub R1, #32
	/* R1=R1*integer((5/9)>>16)*/
	mul R1, R5
	/*Scales down R1 from bp 16 to bp 0 since nineFifths was at bp 16*/
	lsr R1, #16
	/*increment counter R3*/
	add R3, #1
	ldr R6, =counter
	str R3, [R6]
	/*print conversion*/
	ldr R0, =printFormat
	bl printf
	b convertFtoC
endConvertFtoC:

	/*return */
	ldr R1, address_of_return2
	ldr LR, [R1]
	bx LR

address_of_return: .word return
address_of_return2: .word return2
/* 5.0/9.0 at binary point 16 */
fiveNinths: .word 0x8e39
/* 9.0/5.0 at binary point 16 */
nineFifths: .word 0x1cccd

.global printf
.global scanf
