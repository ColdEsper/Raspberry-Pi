/* Chapter 9 on Pages 87-94 */
	.global _start
_start:
	/* EQ */
	movs R0, R1
	moveq R0, #1
	/* NE */
	cmp R5, R6
	addne R5, R5, R6
	/* MI */
	subs R1, R1, #1
	addmi R0, R0, #15
	/* PL */
	subs R1, R1, #1
	addmi R0, R0, #15
	addpl R0, R0, #255
	/* CS */
	add R0, R0, #255
	addcs R1, R1, #15
	/* CC */
	adds R0, R0, #255
	addcs R1, R1, #15
	addcc R1, R1, #128
	/* AL */
	addal R0, R1, R2
	add R0, R1, R2
	/* NV */
	/* addnv R0, R1, R2 @ generates an error on assembling*/
	/* HI */
	cmp R10, R5
	movhi R10, #0
	/* LS */
	cmp R10, R5
	addls R10, R10, #1
	/* GE */
	cmp R5, R6
	addge R5, R5, #255
	/* LT */
	cmp R5, #255
	sublt R5, R5, R6
	/* GT */
	cmp R5, R6
	addgt R0, R1, R2
	/* LE */
	cmp R5, #10
	suble R0, R1, R2

	mov R7, #1
	swi 0
