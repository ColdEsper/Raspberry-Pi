.data
#include<stdio.h>
#include<math.h>


/*For problem:
  diameter = 0.14 ft
  weight = .10125 lbs
  coefficient of drag = .5
  density of air = .0023679
 

float PI = 3.1415926535897932;
float diameter = 0.14;
float weight = 0.10125;
float coefficient = 0.5;
float density = 0.0023679;
float area=0.015393804002589988;
float S0;
float S1;
float S2;
float S3;
float S4;
float S5;
double D0;
double D1;
double D2;*/

pi:
.float 3.1415926535897932
diameter:
.float 0.14
weight:
.float 0.10125
coefficient:
.float 0.5
density:
.float 0.0023679
area:
.float 0.015393804002589988
two:
.float 2.0
half:
.float 0.5
terminalVelocity:
.float 0.0
dynamicPressure:
.float 0.0
start:
.word 0
end:
.word 0
diff:
.word 0

.balign 4
.text

.global main
/*int main () {*/
main:
	push {IP, LR}
	mov R0, #0
	bl time
	ldr R1, =start
	str R0, [R1]
	mov R5, #0
	mov R6, #0
	ldr R7, =65535
	mov R8, #3600
_mainLoop:
	cmp R5, R7
	bhs _mainLoopEnd
	cmp R6, R8
	subhs R6, R8
	addhs R5, #1
	add R6, #1
	/*terminalVelocity = sqrt((2.0f*weight)/(density*area*coefficient));*/
	ldr R0, =weight
	vldr S0, [R0]
	ldr R1, =two
	vldr S1, [R1]
	vmul.F32 S0, S0, S1
	ldr R0, =density
	vldr S1, [R0]
	ldr R0, =area
	vldr S2, [R0]
	vmul.F32 S1, S1, S2
	ldr R0, =coefficient
	vldr S2, [R0]
	vmul.F32 S1, S1, S2
	vdiv.F32 S0, S0, S1
	vsqrt.F32 S0, S0

	/*dynamicPressure = 0.5*density*terminalVelocity*terminalVelocity;*/
	ldr R0, =density
	vldr S2, [R0]
	ldr R0, =terminalVelocity
	vldr S0, [R0]
	vmul.F32 S2, S2, S0
	vmul.F32 S2, S2, S0
	ldr R0, =half
	vldr S3, [R0]
	vmul.F32 S2, S2, S3
	b _mainLoop
_mainLoopEnd:
	mov R0, #0
	bl time
	ldr R1, =end
	str R0, [R1]
	ldr R1, =start
	ldr R1, [R1]
	bl difftime
	ldr R1, =diff
	/*diff time stores it's value in the fpu*/
	fstd D0, [R1]
	/*printf("time it took %f seconds\n",seconds);*/
	vmov R2, R3, D0
	ldr R0, =timeMsg
	bl printf

	//return 0;
	pop {IP, LR}
	bx LR
/*}*/

timeMsg:
.asciz "time it took %f seconds\n"
