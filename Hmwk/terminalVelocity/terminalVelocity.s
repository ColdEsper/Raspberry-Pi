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

.balign 4
.text

.global main
/*int main () {*/
main:
	push {IP, LR}
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

	/*printf("Final velocity is %f\n",terminalVelocity);*/
	ldr R1, =terminalVelocity
	vstr S0, [R1]
	vcvt.F64.F32 D1, S0
	vmov R2, R3, D1
	ldr R0, =velocityMsg
	bl printf
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
	/*printf("Dynamic pressure is %f\n",dynamicPressure);*/
	ldr R1, =dynamicPressure
	vstr S2, [R1]
	vcvt.F64.F32 D2, S2
	vmov R2, R3, D2
	ldr R0, =dynamicMsg
	bl printf

	//return 0;
	pop {IP, LR}
	bx LR
/*}*/

velocityMsg:
.asciz "Final velocity is %f\n"
dynamicMsg:
.asciz "Dynamic pressure is %f\n"
