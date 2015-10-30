.data

mapBoundHigh = 25

.balign 4
/*map is a square that's top left tile or coordinate is (0,0)*/
map: .skip mapBoundHigh*mapBoundHigh

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
.include "usefulMacros.s"
	.global main

/*returns back to main loop after battle*/
.macro initBattle HP, Attack, Defense, Speed, NameAddress
	mov R1, #\HP
	mov R2, #\Attack
	mov R3, #\Defense
	mov R0, #\Speed
	push {R0, R1, R2, R3}
	ldr R0, =(battlers+sizeOfBattler)
	mov R1, #0
	mov R2, #0
	ldr R3, =\NameAddress
	bl initBattler
	ldr R1, =(battlers+sizeOfBattler)
	ldr R0, =battlers
	ldr LR, =mainLoop
	b battle
.endm

main:
	/* save return address*/
	ldr R5, =return
	str LR, [R5]

	/*initialization*/
	mov R0, #0
	bl time
	bl srand
	/* initializes main player*/
	mov R1, #100
	mov R2, #51
	mov R3, #5
	mov R0, #6
	push {R0, R1, R2, R3}
	ldr R0, =battlers
	mov R1, #12
	mov R2, #12
	ldr R3, =playerName
	bl initBattler

mainLoop:
	ldr R5, =battlers
	ldr R0, [R5]
	cmp R0, #0
	ble gameOver
	ldr R0, =mainLoopMessage
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
	b chanceEncounter
moveRight:
	ldr R2, =(battlers+sizeOfStats)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #mapBoundHigh
	bhi mainLoop
	str R3, [R2]
	b chanceEncounter
moveUp:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #mapBoundHigh
	bhi mainLoop
	str R3, [R2]
	b chanceEncounter
moveDown:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	sub R3, R1, #1
	/*branch on overflow (subtracting from 0)*/
	cmp R3, R1
	bhi mainLoop
	str R3, [R2]
	b chanceEncounter
chanceEncounter:
	bl rand
	mov R1, #100
	bl mod
	/* 5 percent chance of enemy encounter */
	cmp R0, #15
	blo genEnemy
	b mainLoop
genEnemy:
	bl rand
	mov R1, #6
	bl mod
enemyOne:
	cmp R0, #0
	bne enemyTwo
	initBattle 50 11 2 5 enemyOneName
enemyTwo:
	cmp R0, #1
	bne enemyThree
	initBattle 55 12 2 5 enemyTwoName
enemyThree:
	cmp R0, #2
	bne enemyFour
	initBattle 60 13 3 5 enemyThreeName
enemyFour:
	cmp R0, #3
	bne enemyFive
	initBattle 67 15 5 6 enemyFourName
enemyFive:
	cmp R0, #4
	bne enemySix
	initBattle 78 17 2 7 enemyFiveName
enemySix:
	initBattle 210 35 10 8 enemySixName
gameOver:
	ldr R0, =deathMessage
	bl printf
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
deathMessage: 
	.asciz "You have died!\n    GAME OVER!\n\n"
.balign 4
mainInputFormat: .asciz "%c"

.global printf
.global scanf
.global getChar
.global srand
.global rand
.global time

.balign 4
playerName: .asciz "Hero"
.balign 4
enemyOneName: .asciz "Enemy V1"
.balign 4
enemyTwoName: .asciz "Enemy V2"
.balign 4
enemyThreeName: .asciz "Enemy V3"
.balign 4
enemyFourName: .asciz "Enemy V4"
.balign 4
enemyFiveName: .asciz "Enemy V5"
.balign 4
enemySixName: .asciz "Enemy V6"

.byte 0x43, 0x61, 0x73, 0x65, 0x79, 0x20, 0x20, 0x43 
.byte 0x6F, 0x70, 0x65, 0x6C, 0x61, 0x6E, 0x64, 0x00
