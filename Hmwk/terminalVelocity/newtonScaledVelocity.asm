.data
/*#include<stdio.h>*/

/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

/* bp -32
unsigned int weight = 0x19eb851e;
//bp -16
unsigned int coefficient = 0x8000;
unsigned int density = 0x9b;
//bp = 2^-22/4=2^-24
//so area = (0.14*0.14*PI*2**(bp-2))
unsigned int area = 258265;
unsigned int terminalVelocity;
unsigned int velocityDenominator;
unsigned int dynamicPressure;
unsigned int R0;
unsigned int R1;
unsigned int R2;
unsigned int R3;
unsigned int R4;
unsigned int R5;
unsigned int R6;
unsigned int R7;
unsigned int R8;*/

weight:
.word 0x19EB851E
coefficient:
.word 0x8000
density:
.word 0x9B
area:
.word 258265
terminalVelocity:
.word 0
dynamicPressure:
.word 0

/*unsigned int value;
void squareRoot () {
	value = R0;
	//unsigned int xGuess = value/2;
	R1 = R0;
	R1 /= 2;
	R2 = R1*R1;
	while (R2 < R1) {
		/*xGuess = xGuess/2;
		R1 /= 2;
		R2 = R1*R1;
	}
	//unsigned int xNext = 0;
	R3 = 0;
	//unsigned int prev = 0;
	R4 = 0;
	//unsigned int prevTwo = 0;
	R5 = 0;
	while (1) {
		//xNext = (xGuess+value/xGuess)/2;
		R6 = value;
		R6 /= R1;
		R0 = R1 + R6;
		R0 /= 2;
		//prevTwo = prev;
		R5 = R4;
		//prev=xGuess;
		R4 = R1;
		//try to prevent jumping back and forth
		//if (xNext == prev || xNext == prevTwo) {
		if (R0 == R4 || R0 == R5) {
			break;
		}
		//xGuess = xNext;
		R1 = R0;
	//}
	/*return xNext;
}*/

.balign 4
.text 
squareRoot:
	push {R1, R2, R3, R4, R5, R6}
	ldr R1, =value
	str R0, [R1]
	bl LR

.global div
.global main
/*int main () {*/
main:
	push {IP, LR}
	/*R0 is velocityDenominator for now*/
	ldr R1, =area
	ldr R1, [R1]
	ldr R0, =density
	mul R0, R1
	/*denominator at bp -16-24 = -40, so shift right to -24*/
	lsr R0, #16
	ldr R1, =coefficient
	ldr R1, [R1]
	mul R0, R1
	/*denominator at bp -24-16=-40, so shift right to -24*/
	lsr R0, #16
	/*move out 2 from calculation as part of binary point shifting*/
	/*terminalVelocity = weight/velocityDenominator;*/
	ldr R3, =weight
	ldr R3, [R3]
	mov R4, R0
	/*R0= R3/R4*/
	mov R0, R3
	mov R1, R4
	bl div
	/*terminal velocity bp now at 1-32+24= -7*/
	lsr R0, #1
	bl squareRoot
	/*R1 is dynamicPressure;*/
	/*1/2 factored out into shifting bp*/
	ldr R2, =density
	ldr R2, [R2]
	mul R2, R0
	mul R2, R0
	/*dynamicPressure=R2;*/
	ldr R3, =dynamicPressure
	str R2, [R3]
	/*terminalVelocity bp at -3 from sqrt, so shift right to 0*/
	lsr R0, #3
	/*printf("Final velocity is %i\n",R0);*/
	mov R1, R0
	mov R0, =velocityMsg
	bl printf
	/*dynamicPressure bp =-1-16-3-3=-23, so shift right to 0*/
	ldr R0, =dynamicPressure
	ldr R0, [R0]
	lsr R0, #23
	//printf("Dynamic pressure is %i\n",R0);
	mov R1, R0
	ldr R0, =dynamicMsg
	bl printf

	//return 0;
	pop {IP, LR}
	bx LR
/*}*/

velocityMsg:
.asciz "Final velocity is %i\n"
dynamicMsg:
.asciz "Dynamic pressure is %i\n"
