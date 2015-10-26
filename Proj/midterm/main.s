.data

/* memory allocation for battlers */
.balign 4
battlers: .skip sizeOfBattler*2

.balign 4
inputChar: .byte 0

.balign 4
return: .word 0

.balign 4
.text
.include "battler.s"
	.global main

.macro compareBothCase upperChar, trueBranch 
	ldr R0, =inputChar
	ldr R0, [R0]
	cmp R0, #\upperChar
	beq \trueBranch
	cmp R0, #(\upperChar+0x20)
	beq \trueBranch
.endm

mapBoundHigh = 25

main:
	/* save return address*/
	ldr R5, =return
	str LR, [R5]

	/*initialization*/
	/* initializes main player*/
	mov R1, #5
	mov R2, #2
	push {R1, R2}
	ldr R0, =battlers
	mov R1, #12
	mov R2, #12
	mov R3, #100
	bl initBattler
	/* initialize enemy */
	mov R1, #3
	mov R2, #2
	push {R1, R2}
	ldr R0, =(battlers+sizeOfBattler)
	mov R1, #0
	mov R2, #0
	mov R3, #100
	bl initBattler

mainLoop:
	ldr R0, =mainLoopMessage
	ldr R5, =battlers
	ldr R3, [R5]
	add R5, R5, #sizeOfStats
	ldr R1, [R5]
	add R5, R5, #(sizeOfCoord/2)
	ldr R2, [R5]
	bl printf
	ldr R0, =mainInputFormat
	ldr R1, =inputChar
	bl scanf
	/* remove newline still in buffer 
	(newline in buffer will printf to print twice when loop repeats)*/
	bl getchar 

	/* compare to ASCII L */
	compareBothCase 0x4C, moveLeft 
	/* compare to ASCII R */
	compareBothCase 0x52, moveRight
	/* compare to ASCII U */
	compareBothCase 0x55, moveUp
	/* compare to ASCII D */
	compareBothCase 0x44, moveDown
	/* compare to ASCII Q*/
	compareBothCase 0x51, endMainLoop 
	b mainLoop
moveLeft:
	ldr R2, =(battlers+sizeOfStats)
	ldr R1, [R2]
	sub R3, R1, #1
	/*branch on overflow (subtracting from 0)*/
	cmp R3, R1
	bhi mainLoop
	str R3, [R2]
	b mainLoop
moveRight:
	ldr R2, =(battlers+sizeOfStats)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #mapBoundHigh
	bhi mainLoop
	str R3, [R2]
	b mainLoop
moveUp:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #mapBoundHigh
	bhi mainLoop
	str R3, [R2]
	b mainLoop
moveDown:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	sub R3, R1, #1
	/*branch on overflow (subtracting from 0)*/
	cmp R3, R1
	bhi mainLoop
	str R3, [R2]
	b mainLoop
endMainLoop:
	/*return*/
	ldr R5, =return
	ldr LR, [R5]
	bx LR

/*constants*/
.balign 4
mainLoopMessage: 
	.ascii "Position: (%d,%d)\n"
	.ascii "HP: %d\n\n"
	.ascii "Press r for Right, l for Left, u for Up, or d for down.\n"
	.asciz "or... Press q to quit\n"
.balign 4
mainInputFormat: .asciz "%c"
