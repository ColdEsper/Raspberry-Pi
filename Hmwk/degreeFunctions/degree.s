.data
.balign 4
display_msg: .asciz "Display Degree Centigrade to Degree Fahrenheight\nFahrenheit Centigrade\n"
.balign 4
input_msg: .asciz "Input beginning and end of temperature range.\n"
.balign 4
range_input_msg: .asciz "If range is degree Centigrade inut 1\nIf range is degree Fahrenheiht input 2\n"
.balign 4
return: .word 0 
.balign 4
return2: .word 0 
.text
	.global main
main:
	ldr R1, address_of_return
	str LR, [R1]

	bl problemTwo

	ldr R1, address_of_return
	ldr LR, [R1]
	bx LR

problemTwo:
	/*save address of return */
	ldr R1, address_of_return2
	str LR, [R1]

	/*print msg*/
	ldr R0, address_of_disp
	bl printf

	/*return */
	ldr R1, address_of_return2
	ldr LR, [R1]
	bx LR

address_of_return: .word return
address_of_return2: .word return2
address_of_disp: .word display_msg

.global printf
.global scanf
