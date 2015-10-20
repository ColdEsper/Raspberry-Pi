.data
.balign 4
display_msg: .asciz "Display Degree Centigrade to Degree Fahrenheit\nFahrenheit Centigrade\n"
.global display_msg
.balign 4
input_msg: .asciz "Input beginning and end of temperature range.\n"
.global input_msg 
.balign 4
range_input_msg: .asciz "If range is degree Centigrade input 1\nIf range is degree Fahrenheit input 2\n"
.global range_input_msg 
.balign 4
inputFormat: .asciz "%d"
.global inputFormat
.balign 4
printFormat: .asciz "         %d\n"
.global printFormat
.balign 4
printFormat2: .asciz "%d "
.global printFormat2
.balign 4
beg: .word 0
.balign 4
end: .word 0
.balign 4
choice: .word 0
.balign 4
return: .word 0 
.balign 4

.text
	.global main
main:
	ldr R1, address_of_return
	str LR, [R1]

whileDo:
	ldr R0, =input_msg
	bl printf
	ldr R0, =inputFormat
	ldr R1, =beg
	bl scanf
	ldr R0, =inputFormat
	ldr R1, =end
	bl scanf
	/* print msg */
	ldr R0, =range_input_msg
	bl printf
	/*get input*/
	ldr R0, =inputFormat
	ldr R1, =choice
	bl scanf
	/*loads up R2 and R3 with memory addresses as args
		for either problem1 or problem2 */
	ldr R2, =beg
	ldr R3, =end
	ldr R1, =choice
	ldr R1, [R1]
	cmp R1, #1
	beq doOne
	cmp R1, #2
	beq doTwo
	b endDo
doOne:
	bl problem1
	b whileDo
doTwo:
	bl problem2
	b whileDo
endDo:

	ldr R1, address_of_return
	ldr LR, [R1]
	bx LR

address_of_return: .word return

.global printf
.global scanf
