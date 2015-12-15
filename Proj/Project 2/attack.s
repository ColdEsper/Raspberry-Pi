.balign 4
.text

.include "battler.s"

.global attack
/*args
   R0 is pointer to attacker
   R1 is pointer to receiver*/
attack:
	push {R2, LR}
	/*HP*/
	vldr S0, [R1]
	/*Defense*/
	vldr S1, [R1,#8]
	/*Attack*/
	vldr S2, [R0,#4]
	vcmp.f32 S2, S1
	vmrs APSR_nzcv, FPSCR
	blt oneDamage
	/*normal damage calculation*/
	vsub.f32 S3, S2, S1
	vsub.f32 S0, S0, S3
	b attackReturn
oneDamage:
	/*subtract 1.0 health*/
	mov R2, #0x3f800000
	vmov S3, R2
	vsub.f32 S0, S0, S3
attackReturn:
	vstr S0, [R1]
	ldr R2, [R1,#(sizeOfStats+sizeOfCoord)]
	ldr R1, [R0,#(sizeOfStats+sizeOfCoord)]
	ldr R0, =attackMsg
	
	bl printf
	pop {R2, LR}
	bx LR

attackMsg:
.asciz "%s attacked %s!\n"
