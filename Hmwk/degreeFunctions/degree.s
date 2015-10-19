.data
.balign 4
display_msg: .asciz "Display Degree Centigrade to Degree Fahrenheight\nFahrenheit Centigrade\n"
.balign 4
input_msg: .asciz "Input beginning and end of temperature range.\n"
.balign 4
range_input_msg: .asciz "If range is degree Centigrade input 1\nIf range is degree Fahrenheiht input 2\nIf quitting desired input 3\n"
.balign 4
inputFormat: .asciz "%d"
.balign 4
start: .word 0
.balign 4
end: .word 0
.balign 4
choice: .word 0
.balign 4
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
	/* jump to conversion function, else repeat quesition */
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

problemOne:
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

.global printf
.global scanf
