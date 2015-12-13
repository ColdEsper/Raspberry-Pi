.data
mapWidth: .word 0
mapSize: .word 0
mapPointer: .word 0
mapStart: .word 0
mapEnd: .word 0
return: .word 0
.balign 4
.text
.global mapInit
/* args:
	R0 = address to char array of map to fill
	R1 = character to fill array of map with 
	R2 = size of map*/
mapInit:
	mov R3, R0
	add R3, R3, R2
	mov R4, R1
	/*R1 is 4 bytes, so fill all 4 bytes with same pattern*/
	lsl R4, #8
	orr R1, R4
	mov R4, R1
	lsl R4, #16
	orr R1, R4
mapInitLoop:
	cmp R0, R3
	bhs mapInitEnd
	str R1, [R0]
	add R0, R0, #4
	b mapInitLoop
mapInitEnd:
	bx LR

.global mapDisplay
/* args:
	R0 is address to char array of map 
	R1 is map width 
	R2 is map size */
mapDisplay:
	ldr R3, =return
	str LR, [R3]
	ldr R3, =mapStart
	str R0, [R3]
	ldr R3, =mapPointer
	str R0, [R3]
	ldr R3, =mapEnd
	add R0, R0, R2
	str R0, [R3]
	ldr R3, =mapWidth
	str R1, [R3]
	ldr R3, =mapSize
	str R2, [R3]
	ldr R0, =mapPointer
	ldr R0, [R0]
mapDisplayLoop:
	ldr R3, =mapEnd
	ldr R3, [R3]
	cmp R0, R3
	beq mapDisplayEnd
	ldr R1, =mapStart
	ldr R1, [R1]
	sub R0, R0, R1
	ldr R1, =mapWidth
	ldr R1, [R1]
	bl mod
	cmp R0, #0
	bne printMapSquare
	ldr R0, =newLineMessage
	bl printf
printMapSquare:
	ldr R0, =mapSquareMessage
	ldr R1, =mapPointer
	ldr R1, [R1]
	ldr R1, [R1]
	bl printf
	ldr R0, =mapPointer
	ldr R1, [R0]
	add R1, R1, #1
	str R1, [R0]
	mov R0, R1
	b mapDisplayLoop
mapDisplayEnd:
	ldr LR, =return
	ldr LR, [LR]
	bx LR

.global mapCoordinateToIndex
/*args:
	R0 is pointer to coordinate
	R1 is map width*/
mapCoordinateToIndex:
	ldr R3, =return
	str LR, [R3]
	mov R2, R0
	add R2, R2, #4
	ldr R0, [R0]
	ldr R2, [R2]
	mul R3, R2, R1
	add R0, R0, R3
	ldr LR, =return
	ldr LR, [LR]
	bx LR

.global mapSwapCoordinates
/*args:
	R0 is pointer to coordinate
	R1 is pointer to other coordinate
	R2 is map width*/
mapSwapCoordinates:
	ldr R3, =return
	str LR, [R3]
	ldr R3, =mapWidth
	str R2, [R3]
	mov R4, R1
	mov R1, R2
	bl mapCoordinateToIndex
	mov R3, R0
	mov R0, R4
	mov R4, R3
	ldr R1, =mapWidth
	ldr R1, [R1]
	bl mapCoordinateToIndex
	ldr R2, [R4]
	ldr R1, [R0]
	str R2, [R0]
	str R1, [R4]
	ldr LR, =return
	ldr LR, [LR]
	bx LR

mapSquareMessage: .asciz "%c"
newLineMessage: .asciz "\n"
