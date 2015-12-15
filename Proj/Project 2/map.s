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
	push {IP, LR}
	/* stack:
	   pointer [SP,#0],
	   start of map #4, 
	   end #8,
	   width #12, 
	   map size #16 */
	sub SP, #24
	str R0, [SP]
	str R0, [SP,#4]
	add R0, R0, R2
	str R0, [SP,#8]
	str R1, [SP,#12]
	str R2, [SP,#16]
	ldr R0, [SP]
mapDisplayLoop:
	/*if pointer reached end, exit*/
	ldr R3, [SP,#8]
	cmp R0, R3
	beq mapDisplayEnd
	/* if end of row reached, print new line */
	ldr R1, [SP,#4]
	sub R0, R0, R1
	ldr R1, [SP,#12]
	bl mod
	cmp R0, #0
	bne printMapSquare
	ldr R0, =newLineMessage
	bl printf
printMapSquare:
	ldr R0, =mapSquareMessage
	ldr R1, [SP]
	ldr R1, [R1]
	bl printf
	/*increment pointer*/
	ldr R1, [SP]
	add R1, R1, #1
	str R1, [SP]
	mov R0, R1
	b mapDisplayLoop
mapDisplayEnd:
	add SP, #24
	pop {IP, LR}
	bx LR

.global mapCoordinateToIndex
/*args:
	R0 is pointer to coordinate
	R1 is map width*/
mapCoordinateToIndex:
	mov R2, R0
	add R2, R2, #4
	ldr R0, [R0]
	ldr R2, [R2]
	mul R3, R2, R1
	add R0, R0, R3
	bx LR

.global mapSwapCoordinates
/*args:
	R0 is pointer to coordinate
	R1 is pointer to other coordinate
	R2 is map width*/
mapSwapCoordinates:
	push {IP, LR}
	sub SP, #8
	str R2, [SP]
	mov R4, R1
	mov R1, R2
	bl mapCoordinateToIndex
	mov R3, R0
	mov R0, R4
	mov R4, R3
	ldr R1, [SP]
	bl mapCoordinateToIndex
	/*perform swap based on indexes*/
	ldr R2, [R4]
	ldr R1, [R0]
	str R2, [R0]
	str R1, [R4]
	add SP, #8
	pop {IP, LR}
	bx LR

mapSquareMessage: .asciz "%c"
newLineMessage: .asciz "\n"
