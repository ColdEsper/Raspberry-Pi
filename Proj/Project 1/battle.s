.data
.balign 4
return: .word 0
.balign 4
inputChar: .word 0

.balign 4
.text
.global battle

.include "battler.s"
.include "usefulMacros.s"

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
	add R1, #(sizeOfStats+sizeOfCoord)
	ldr R1, [R1]
	bl printf
battleLoop:
	ldr R0, =battleLoopMessage
	ldr R1, [R5]
	ldr R2, [R6]
	bl printf
	ldr R0, =inputFormat
	ldr R1, =inputChar
	bl scanf
	bl getchar
	/* compare to A */
	compareBothCase 0x41 attackEnemy
	/* compare to B */
	compareBothCase 0x42 run
	b battleLoop
attackEnemy:
	mov R0, R5
	mov R1, R6
	bl attack
	b battleLoop
run:
	mov R0, R5
	mov R1, R6
battleLoopEnd:
	/*return*/
	ldr R5, =return
	ldr LR, [R5]
	bx LR

.balign 4
encounterMessage:
	.asciz "%s encountered!\n"
.balign 4
battleLoopMessage:
	.ascii "HP: %d     Enemy HP: %d\n"
	.ascii "--------------------------\n"
	.ascii "| a)Attack    b)Run      |\n"
	.ascii "--------------------------\n"
	.asciz "Which option do you choose?\n"
.balign 4
inputFormat: .asciz "%c"

.global printf
.global scanf
.global getChar
.global rand
