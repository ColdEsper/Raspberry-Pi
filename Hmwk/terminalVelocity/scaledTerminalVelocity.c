#include<stdio.h>
#include<math.h>

#define PI 3.1415926535897932

/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

int squareRoot (int value) {
	int xGuess = value/2;
	int xNext = 0;
	int deltaX = 255;
	int sign = 0;
	while (deltaX > 0) {
		xNext = xGuess - (xGuess*xGuess-value)/(2*xGuess);
		deltaX = xNext-xGuess;
		if (deltaX < 0) {
			deltaX = -deltaX;
			//check for jumping back and forth
			if  (deltaX < 3 && sign == 1) {
				break;
			}
			sign = -1;
		} else {
			//check for jumping back and forth
			if  (deltaX < 3 && sign == -1) {
				break;
			}
			sign = 1;
		}
		xGuess = xNext;
	}
	return xNext;
}

int main () {
	/* bp -32*/
	unsigned int weight = 0x19eb851e;
	/* bp -16*/
	unsigned int coefficient = 0x8000;
	//bp = 2^-22/4=2^-24
	//so area = (0.14*0.14*PI*2**(bp-2))
	unsigned int area = 258265;
	unsigned int density = 0x9b;
	unsigned int terminalVelocity;
	unsigned int velocityDenominator;

	velocityDenominator = density*area;
	//denominator at bp -24-16 = -40, so shift right to -24
	velocityDenominator>>=16;
	velocityDenominator*=coefficient;
	//denominator at bp -24-16=-40, so shift right to -24
	velocityDenominator>>=16;
	//move out 2 from calculation as part of binary point shifting
	terminalVelocity = weight/velocityDenominator;
	//terminal velocity bp now at 1-32+24= -7
	terminalVelocity>>=1;
	terminalVelocity = sqrt(terminalVelocity);
	//terminalVelocity bp now at -3, so shift right to 0
	terminalVelocity>>=3;
	printf("Final velocity is %d\n",terminalVelocity);

	return 0;
}
