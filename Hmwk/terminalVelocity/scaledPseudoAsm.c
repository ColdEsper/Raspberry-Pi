#include<stdio.h>

/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

/* bp -32*/
unsigned int weight = 0x19eb851e;
/* bp -16*/
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
unsigned int R8;

unsigned int value;
void squareRoot () {
	value = R0;
	//unsigned int xGuess = value/2;
	R1 = R0;
	R1 /= 2;
	R2 = R1*R1;
	while (R2 < R1) {
		//xGuess = xGuess/2;
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
	}
	//return xNext;
}

int main () {
	//R0 is velocityDenominator for now
	R1 = area;
	R0 = density;
	R0 *= R1;
	//denominator at bp -16-24 = -40, so shift right to -24
	R0>>=16;
	R1 = coefficient;
	R0*=R1;
	//denominator at bp -24-16=-40, so shift right to -24
	R0>>=16;
	//move out 2 from calculation as part of binary point shifting
	//terminalVelocity = weight/velocityDenominator;
	R3= weight;
	R4 = R0;
	R0= R3/R4;
	//terminal velocity bp now at 1-32+24= -7
	R0>>=1;
	squareRoot();
	//R1 is dynamicPressure;
	//1/2 factored out into shifting bp
	R2=density;
	R2*=R0;
	R2*=R0;
	dynamicPressure=R2;
	//terminalVelocity bp at -3 from sqrt, so shift right to 0
	R0>>=3;
	printf("Final velocity is %d\n",R0);
	//dynamicPressure bp =-1-16-3-3=-23, so shift right to 0
	R0 = dynamicPressure;
	R0>>=23;
	printf("Dynamic pressure is %d\n",R0);

	return 0;
}
