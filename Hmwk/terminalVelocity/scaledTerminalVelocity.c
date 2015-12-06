#include<stdio.h>
#include<math.h>

/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

int main () {
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

	velocityDenominator = density*area;
	//denominator at bp -16-24 = -40, so shift right to -24
	velocityDenominator>>=16;
	velocityDenominator*=coefficient;
	//denominator at bp -24-16=-40, so shift right to -24
	velocityDenominator>>=16;
	//move out 2 from calculation as part of binary point shifting
	terminalVelocity = weight/velocityDenominator;
	//terminal velocity bp now at 1-32+24= -7
	terminalVelocity>>=1;
	terminalVelocity = sqrt(terminalVelocity);
	//1/2 factored out into shifting bp
	dynamicPressure=density*terminalVelocity*terminalVelocity;
	//terminalVelocity bp at -3 from sqrt, so shift right to 0
	terminalVelocity>>=3;
	printf("Final velocity is %d\n",terminalVelocity);
	//dynamicPressure bp =-1-16-3-3=-23, so shift right to 0
	dynamicPressure>>=23;
	printf("Dynamic pressure is %d\n",dynamicPressure);

	return 0;
}
