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
	/*check if enemy and player are still alive*/
	vldr S1, [R6]
	vcmp.f32 S1, #0
	vmrs APSR_nzcv, FPSCR
	ble battleLoopEnd
	vldr S0, [R5]
	vcmp.f32 S0, #0
	vmrs APSR_nzcv, FPSCR
	ble battleLoopEnd
	/*display battle menu*/
	ldr R0, =battleLoopMessage
	/*push enemy hp onto stack for printf due to calling
	 convention only using up to R4*/
	vldr S0, [R6]
	vcvt.f64.f32 D1, S0
	vmov R2, R3, D1
	push {R2, R3}
	vldr S0, [R5]
	vcvt.f64.f32 D1, S0
	vmov R2, R3, D1
	bl printf
	pop {R2, R3}
	ldr R0, =inputFormat
	ldr R1, =inputChar
	bl scanf
	bl getchar
	/* compare input to A */
	compareBothCase 0x41 attackEnemy
	/* compare input to B */
	compareBothCase 0x42 run
	b battleLoop
attackEnemy:
	/*compare speed*/
	vldr S0, [R5,#12]
	vldr S1, [R6,#12]
	vcmp.f32 S0, S1
	vmrs APSR_nzcv, FPSCR
	/*player attacks first if faster*/
	movge R0, R5
	movge R1, R6
	/*else enemy attacks first*/
	movlt R1, R5
	movlt R0, R6
	push {R0, R1}
	bl attack
	pop {R0, R1}
	/*checks if receiver of attack died*/
	vldr S0, [R1]
	vcmp.f32 S0, #0
	vmrs APSR_nzcv, FPSCR
	ble battleLoopEnd
	/*counter attack if alive*/
	mov R2, R0
	mov R0, R1
	mov R1, R2
	bl attack
	b battleLoop
run:
	/*compare speed*/
	mov R0, R5
	vldr S0, [R0,#12]
	mov R1, R6
	vldr S1, [R1,#12]
	vcmp.f32 S0, S1
	vmrs APSR_nzcv, FPSCR
	bgt runSuccess
	bl rand
	mov R1, #100
	bl mod
	/* 20 percent chance of running when slower*/
	cmp R0, #20
	blo runSuccess
	ldr R0, =runFailMsg
	bl printf
	mov R1, R5
	mov R0, R6
	bl attack
	b battleLoop
runSuccess:
	ldr R0, =runSuccessMsg
	bl printf
battleLoopEnd:
	ldr R0, =score
	ldr R1, [R0]
	add R1, R1, #1 
	str R1, [R0]
	/*return*/
	ldr R5, =return
	ldr LR, [R5]
	bx LR

.balign 4
encounterMessage:
	.asciz "%s encountered!\n"
.balign 4
battleLoopMessage:
	.ascii "HP: %f     Enemy HP: %f\n"
	.ascii "--------------------------\n"
	.ascii "| a)Attack    b)Run      |\n"
	.ascii "--------------------------\n"
	.asciz "Which option do you choose?\n"
.balign 4
inputFormat: .asciz "%c"
runFailMsg: .asciz "You couldn't escape!\n"
runSuccessMsg: .asciz "You ran away!\n"

.global printf
.global scanf
.global getchar
.global rand
