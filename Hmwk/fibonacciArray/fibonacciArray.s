.text
.global main

/*args:
	void
input:
	term wanted is expected to be in range 1-45
return: 
	R0 is term wanted*/
main:
	push {IP, LR}
	ldr R0, =termWantedMsg
	bl printf
	ldr R0, =askTermFormat
	/*use stack to return term wanted from scanf*/
	sub SP, SP, #8
	mov R1, SP
	bl scanf
	bl getchar
	/*pop from stack term wanted*/
	mov R1, SP
	ldr R1, [R1]
	add SP, SP, #8
	mov R2, #2
	mov R0, #1
	/* allocate first two terms */
	sub SP, SP, #8
	str R0, [SP]
	str R0, [SP,#4]
	/*loop starts at 3rd term, returns 1 if less than 3, returns 0 for 0*/
	cmp R1, #0
	beq invalidIndex
	cmp R2, R1
	bge endFibLoop
	cmp R1, #45
	bhi invalidIndex
	/* check if odd */
	mov R4, R1
	and R4, #1
	cmp R4, #1
	bne fibLoop
	/* allocate two terms, of which one will be written to 
	   due to odd number of terms */
	sub SP, SP, #8
	add R2, R2, #1
	str R0, [SP,#4]
	b fibLoopOddStart
fibLoop:
	/* allocate two terms at a time*/
	sub SP, SP, #8
	add R2, R2, #2
	ldr R4, [SP,#8]
	ldr R3, [SP,#12]
	add R3, R3, R4
	str R3, [SP,#4]
fibLoopOddStart:
	add R3, R3, R4
	str R3, [SP]
	cmp R2, R1
	blo fibLoop
endFibLoop:
	ldr R0, =termCalculatedMsg
	ldr R2, [SP]
	push {R1, IP}
	bl printf
	pop {R1, IP}
	/*R0 is return value*/
	ldr R0, [SP]
popAllFib:
	cmp R1, #1 
	blt endPopAllFib
	add SP, SP, #8
	sub R1, R1, #2
	b popAllFib
endPopAllFib:
	pop {IP, LR}
	bx LR
invalidIndex:
	add SP, SP, #8
	ldr R0, =invalidTermMsg
	bl printf
	/*R0 is return value*/
	mov R0, #0
	b endPopAllFib

termWantedMsg: .asciz "Which term is desired? (must be less than 45) \n"
askTermFormat: .asciz "%d"
termCalculatedMsg: .asciz "Term at %d is %d\n"
invalidTermMsg: .asciz "Term given is too high or 0! 0 returned\n"

.global printf
.global getchar
.global scanf
