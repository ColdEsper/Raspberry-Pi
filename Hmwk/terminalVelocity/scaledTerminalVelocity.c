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
	//unsigned int weight = 0x19eb851e;
	/* bp -16*/
	unsigned int weight = 0x19eb;
	unsigned int coefficient = 0x8000;
	//2^-14/4=2^-16
	unsigned int area = (0.14*0.14*PI*2*2*2*2*2*2*2*2*2*2*2*2*2*2);
	printf("area %d\n",area);
	unsigned int density = 0x9b;
	unsigned int terminalVelocity;
	unsigned int velocityDenominator;

	velocityDenominator = density*area;
	printf("denomb %d\n", velocityDenominator);
	//denominator at bp -16-16 = -32, so shift right to -16
	velocityDenominator>>=16;
	velocityDenominator*=coefficient;
	printf("denomc %d\n", velocityDenominator);
	//denominator at bp -16-16=-32, so shift right to -24
	//velocityDenominator>>=8;
	velocityDenominator>>=16;
	printf("denom %d\n", velocityDenominator);
	//move out 2 from calculation as part of binary point shifting
	terminalVelocity = 2*weight/velocityDenominator;
	printf("bvelocity %d\n",terminalVelocity);
	//terminal velocity bp now at 1-32+24= -7
	//terminal velocity bp now at 1-16+16= -1
	printf("vvelocity %d\n",terminalVelocity);
	terminalVelocity = squareRoot(terminalVelocity);
	//terminalVelocity bp now at -4, so shift right to 0
	//terminalVelocity>>=4;
	printf("Final velocity is %d\n",terminalVelocity);

	return 0;
}
