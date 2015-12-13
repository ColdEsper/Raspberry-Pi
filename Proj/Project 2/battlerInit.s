.data
.balign 4
return2: .word 0

.balign 4
.text
.include "battler.s"

/* Init Functions */
.global initCoord
.global initBattler
.global initStats

/*args:
	R0 is memory pointer to coordinate structure
	R1 is X value
	R2 is Y value
*/
initCoord:
	/* X = 0 */
	str R1, [R0]
	/* Y = 0 */
	str R2, [R0,#4]
	bx LR

/*args:
	R0 is memory pointer to stats structure
	R1 is HP
	R2 is Attack
	R3 is Defense
	on stack: Speed
*/
initStats:
	/*set HP*/
	str R1, [R0]
	/*set Attack*/
	str R2, [R0,#4]
	/*set Defense */
	str R3, [R0,#8]
	mov R5, R0
	pop {R0, IP}
	/*set Speed */
	str R0, [R5,#12]
	bx LR

/*args:
	R0 is memory pointer to battler structure
	R1 is coordinate X
	R2 is coordinate Y
	R3 is pointer to name
	on stack: Speed, HP, Attack,Defense
*/
initBattler:
	/* save return address */
	ldr R5, =return2
	str LR, [R5]
	add R0, R0, #sizeOfStats
	bl initCoord
	add R0, R0, #sizeOfCoord
	str R3, [R0]
	sub R0, R0, #(sizeOfStats+sizeOfCoord)
	mov R5, R0
	pop {R0, R1, R2, R3}
	push {R0, IP}
	mov R0, R5
	bl initStats
	/* return */
	ldr R5, =return2
	ldr LR, [R5]
	bx LR
