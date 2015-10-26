.data
.balign 4
return: .word 0

.balign 4
.text
.global battle

/* args:
	R0 is pointer to controllable battler
	R1 is pointer to AI battler */
battle:
	/*save return address*/
	ldr R5, =return
	str LR, [R5]

	mov R5, R0
	mov R6, R1
	ldr R0, =encounterMessage
	bl printf
battleLoop:
	ldr R0, =battleLoopMessage
	ldr R1, [R5]
	ldr R2, [R6]
	bl printf
	/*b battleLoop*/
battleLoopEnd:
	/*return*/
	ldr R5, =return
	ldr LR, [R5]
	bx LR

.balign 4
encounterMessage:
	.asciz "Enemy encountered!\n"
.balign 4
battleLoopMessage:
	.asciz "HP: %d     Enemy HP: %d\n"

.global printf
.global scanf
.global getChar
