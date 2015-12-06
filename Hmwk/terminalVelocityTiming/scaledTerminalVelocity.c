#include<stdio.h>
#include<math.h>
#include<time.h>

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

	time_t end;
	double seconds;
	unsigned int i;
	unsigned int j;
	time_t start = time(NULL);
	for (i=0;i<65535;++i) {
		for (j=0;j<3600;j++) {
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
			//dynamicPressure bp =-1-16-3-3=-23, so shift right to 0
			dynamicPressure>>=23;
		}
	}
	end = time(NULL);
	seconds = difftime(end,start);
	printf("time it took %f seconds\n",seconds);

	return 0;
}
