.text
	.global main
main:
	push {IP, LR}
	ldr R0, =askTermMsg
	bl printf
	ldr R0, =inputTermFormat
	sub SP, #4
	mov R1, SP
	bl scanf
	bl getchar
	ldr R0, [SP]
	add SP, #4
	bl fibonacci
	mov R1, R0
	ldr R0, =printMsg
	bl printf
	pop {IP, LR}
	bx LR

askTermMsg: .asciz "Which term is desired?\n"
inputTermFormat: .asciz "%d"
printMsg: .asciz "Term is %d\n"

.global printf
.global scanf
.global getchar
