.macro compareBothCase upperChar, trueBranch 
	ldr R0, =inputChar
	ldr R0, [R0]
	cmp R0, #\upperChar
	beq \trueBranch
	cmp R0, #(\upperChar+0x20)
	beq \trueBranch
.endm
