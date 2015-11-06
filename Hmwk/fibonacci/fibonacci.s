.text
.global fibonacci
/*args: 
	R0 is term wanted
  return:
	returns fibonacciRecur's return*/
fibonacci:
	mov R1, #1
	/*push term wanted*/
	sub SP, #8
	str R0, [SP]
	/*push previous terms as both 1*/
	sub SP, #8
	str R1, [SP]
	sub SP, #8
	str R1, [SP]
/*args: 
	on stack: previous term, second previous term, term wanted
  return: 
	R0 is value at term*/
fibonacciRecur:
	/*pop args*/
	ldr R2, [SP]
	add SP, #8
	ldr R1, [SP]
	add SP, #8
	ldr R0, [SP]
	add SP, #8
	/*push LR*/
	sub SP, #8
	str LR, [SP]

	cmp R0, #2
	bls fibEnd
	add R3, R1, R2
	mov R1, R2
	mov R2, R3
	sub R0, #1
	/*push args for next recursion*/
	sub SP, #8
	str R0, [SP]
	sub SP, #8
	str R1, [SP]
	sub SP, #8
	str R2, [SP]
	bl fibonacciRecur
fibEnd:
	mov R0, R2
	/*pop LR*/
	ldr LR, [SP]
	add SP, #8
	bx LR
