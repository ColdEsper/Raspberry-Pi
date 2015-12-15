/* assumes char to compare has been put on the stack
   pops off the stack for you if it jumps to branch */
.macro compareBothCase upperChar, trueBranch 
	ldr R0, [SP]
	cmp R0, #\upperChar
	beq \trueBranch
	cmp R0, #(\upperChar+0x20)
	addeq SP, #8
	beq \trueBranch
.endm
