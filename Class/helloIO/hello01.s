.data

greeting:
	.asciz "Hello world"

.balign 4
	return: .word 0

.text

.global main
main:
	ldr R1, address_of_return
	str LR, [R1]
	ldr R0, address_of_greeting
	bl puts
	ldr R1, address_of_return
	ldr lr, [r1]
	bx lr
address_of_greeting: .word greeting
address_of_return: .word return

.global puts
