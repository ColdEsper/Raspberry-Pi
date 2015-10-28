.balign 4
.text

.global attack
/*args
   R0 is pointer to attacker
   R1 is pointer to receiver*/
attack:
	/*HP*/
	ldr R2, [R1]
	/*Defense*/
	ldr R3, [R1,#8]
	/*Attack*/
	ldr R0, [R0,#4]
	cmp R0, R3
	bhs oneDamage
/*normal damage calculation*/
	sub R3, R3, R0
	sub R2, R2, R3
	b attackReturn
oneDamage:
	mov R3, #1
	sub R2, R2, R3
attackReturn:
	str R2, [R1]
	bx LR
