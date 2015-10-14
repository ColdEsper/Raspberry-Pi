.balign 4
return2: .word 0

.text

mult_by_5:
	ldr R1, address_of_return2
	str LR, [R1]

	add R0, R0, R0, lsl #2
	
	ldr LR, address_of_return2
	ldr LR, [LR]
	bx LR
address_of_return2: .word return2
