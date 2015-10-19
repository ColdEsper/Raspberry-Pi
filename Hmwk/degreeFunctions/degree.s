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
printFormat: .asciz "%d\n"
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
	ldr R3, =start
	ldr R3, [R3]
	ldr R6, =counter
	str R3, [R6]
	ldr R5, =end
	ldr R4, [R5]
	add R4, #1
	str R4, [R5]
	b convertCtoFStart
convertCtoF:
	ldr R3, =counter
	ldr R3, [R3]
	ldr R4, =end
	ldr R4, [R4]
convertCtoFStart:
	cmp R3, R4
	beq endConvertCtoF
	mov R2, R3
	/*now scales up R2 to bp 7*/
	lsl R2, #7
	ldr R5, =nineFifths
	ldr R5, [R5]
	mul R2, R5
	/*now scales down R2 from bp 7 to bp 0*/
	lsr R2, #7
	add R2, #32
	/*increment counter R3*/
	add R3, #1
	ldr R6, =counter
	str R3, [R6]
	/*print conversion*/
	ldr R0, =printFormat
	mov R1, R2
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

	/*return */
	ldr R1, address_of_return2
	ldr LR, [R1]
	bx LR

address_of_return: .word return
address_of_return2: .word return2
/* 5.0/9.0 at binary point 7 */
fiveNinths: .word 0x47
/* 9.0/5.0 at binary point 7 */
nineFifths: .word 0xe6

.global printf
.global scanf
