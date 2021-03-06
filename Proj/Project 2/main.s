.data

.global score 
.balign 4
score: .word 0

mapBoundHigh = 25

.balign 4
/*map is a square that's top left tile or coordinate is (0,0)*/
map: .skip mapBoundHigh*mapBoundHigh

/* memory allocation for battlers */
.balign 4
battlers: .skip sizeOfBattler*2

.balign 4
.text
.include "battler.s"
.include "usefulMacros.s"
	.global main

/*returns back to main loop after battle*/
.macro initBattle HP, Attack, Defense, Speed, NameAddress
	ldr R1, =\HP
	ldr R2, =\Attack
	ldr R3, =\Defense
	ldr R0, =\Speed
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
.macro moveSwapMapBytes difference
	ldr R0, =(battlers+sizeOfStats)
	mov R1, #mapBoundHigh
	bl mapCoordinateToIndex
	ldr R1, =map
	add R0, R0, R1
	add R2, R0, #\difference
	#swap characters in map
	ldr R1, [R0]
	ldr R3, [R2]
	str R1, [R2]
	str R3, [R0]
.endm

main:
	/* save return address*/
	push {IP, LR}

	/*initialization*/
	mov R0, #0
	bl time
	bl srand
	/* initialize map*/
	ldr R0, =map
	/* ASCII '^' */
	mov R1, #0x5E
	ldr R2, =(mapBoundHigh*mapBoundHigh)
	bl mapInit
	/* initializes main player*/
	/*HP*/
	mov R1, #100
	vmov S1, R1
	vcvt.f32.u32 S0, S1
	vmov R1, S0
	/*Attack*/
	mov R2, #51
	vmov S1, R2
	vcvt.f32.u32 S0, S1
	vmov R2, S0
	/*Defense*/
	mov R3, #5
	vmov S1, R3
	vcvt.f32.u32 S0, S1
	vmov R3, S3
	/*Speed*/
	mov R0, #6
	vmov S1, R0
	vcvt.f32.u32 S0, S1
	vmov R0, S0
	push {R0, R1, R2, R3}
	ldr R0, =battlers
	/*Position*/
	mov R1, #12
	mov R2, #12
	ldr R3, =playerName
	bl initBattler
	ldr R0, =(battlers+sizeOfStats)
	mov R1, #mapBoundHigh
	bl mapCoordinateToIndex
	ldr R1, =map
	add R1, R1, R0
	/*shifts map pointer over 3 bytes so write places
	  'Y' in correct byte*/
	sub R1, R1, #3
	/*load map bytes for later inclusive or*/
	ldr R2, [R1]
	lsl R2, #8
	lsr R2, #8
	/* player represented by 'Y' */
	mov R3, #0x59
	lsl R3, #24
	/*keep map bytes since registers are 4 bytes*/
	orr R3, R2
	str R3, [R1]

mainLoop:
	ldr R6, =battlers
	vldr S0, [R6]
	vcmp.f32 S0, #0
	vmrs APSR_nzcv, FPSCR
	ble gameOver
	ldr R0, =mainLoopStatusMessage
	vldr S0, [R6]
	vcvt.f64.f32 D1, S0
	vmov R4, R5, D1
	/* R5 outside standard calling convention, 
	   so push onto stack for printf*/
	push {R4, R5}
	add R6, R6, #sizeOfStats
	ldr R1, [R6]
	add R6, R6, #(sizeOfCoord/2)
	ldr R2, [R6]
	bl printf
	pop {R4, R5}
	ldr R0, =map
	mov R1, #mapBoundHigh
	ldr R2, =(mapBoundHigh*mapBoundHigh)
	bl mapDisplay
	ldr R0, =mainLoopControlsMessage
	bl printf
	ldr R0, =mainInputFormat
	sub SP, #8
	mov R1, SP
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
	add SP, #8
	b mainLoop
moveLeft:
	ldr R2, =(battlers+sizeOfStats)
	ldr R1, [R2]
	sub R3, R1, #1
	/*branch on overflow (subtracting from 0)*/
	cmp R3, R1
	bhi mainLoop
	str R3, [R2]
	moveSwapMapBytes 1
	b chanceEncounter
moveRight:
	ldr R2, =(battlers+sizeOfStats)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #(mapBoundHigh-1)
	bhi mainLoop
	str R3, [R2]
	moveSwapMapBytes (-1)
	b chanceEncounter
moveDown:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	add R3, R1, #1
	cmp R3, #(mapBoundHigh-1)
	bhi mainLoop
	str R3, [R2]
	moveSwapMapBytes (-mapBoundHigh)
	b chanceEncounter
moveUp:
	ldr R2, =(battlers+sizeOfStats+sizeOfCoord/2)
	ldr R1, [R2]
	sub R3, R1, #1
	/*branch on overflow (subtracting from 0)*/
	cmp R3, R1
	bhi mainLoop
	str R3, [R2]
	moveSwapMapBytes mapBoundHigh
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
	/*50.0, 11.5, 2.0, 5.0*/
	initBattle 0x42480000 0x41380000 0x40000000 0x40A00000 enemyOneName
enemyTwo:
	cmp R0, #1
	bne enemyThree
	/*55.0, 12.5, 2.0, 5.1*/
	initBattle 0x425C0000 0x41480000 0x40000000 0x40A33333 enemyTwoName
enemyThree:
	cmp R0, #2
	bne enemyFour
	/*60.0, 13.5, 3.0, 5.2*/
	initBattle 0x42700000 0x41580000 0x40400000 0x40A66666 enemyThreeName
enemyFour:
	cmp R0, #3
	bne enemyFive
	/*67.0 15.5 5.0 6.0*/
	initBattle 0x42860000 0x41780000 0x40a00000 0x40c00000 enemyFourName
enemyFive:
	cmp R0, #4
	bne enemySix
	/*78.0, 17.5, 2.0, 7.0*/
	initBattle 0x429C0000 0x418C0000 0x40000000  0x40E00000 enemyFiveName
enemySix:
	/*210.0, 35.0, 10.0, 8.0*/
	initBattle 0x43520000 0x420C0000 0x41200000 0x41000000  enemySixName
gameOver:
	ldr R0, =deathMessage
	bl printf
endMainLoop:
	ldr R0, =scoreMessage
	ldr R1, =score
	ldr R1, [R1]
	bl printf
	/*return*/
	pop {IP, LR}
	bx LR

/*constants*/
.balign 4
mainLoopStatusMessage: 
	.ascii "Position: (%d,%d)\n"
	.asciz "HP: %f\n"
mainLoopControlsMessage:
	.ascii "\nPress r for Right, l for Left, u for Up, or d for down.\n"
	.asciz "or... Press q to quit\n"
deathMessage: 
	.asciz "You have died!\n    GAME OVER!\n\n"
scoreMessage: 
	.asciz "You entered %d battles.\n"
.balign 4
mainInputFormat: .asciz "%c"

.global printf
.global scanf
.global getchar
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
