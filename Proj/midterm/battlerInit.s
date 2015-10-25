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

initCoord:
	/* X = 0 */
	mov R5, #0
	str R5, [R0]
	/* Y = 0 */
	str R5, [R0,#4]
	bx LR

initStats:
	/*set HP to 100 */
	mov R5, #100
	str R5, [R0]
	/*set Attack to 5 */
	mov R5, #5
	str R5, [R0,#4]
	bx LR

initBattler:
	/* save return address */
	ldr R5, =return2
	str LR, [R5]
	bl initStats
	add R0, R0, #sizeOfStats
	bl initCoord
	/* return */
	ldr R5, =return2
	ldr LR, [R5]
	bx LR
