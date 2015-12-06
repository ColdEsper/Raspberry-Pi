#include<stdio.h>
#include<math.h>
#include<time.h>


/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

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
double D2;

int main () {
	time_t end;
	double seconds;
	unsigned int i;
	unsigned int j;
	time_t start = time(NULL);
	for (i=0;i<65535;++i) {
		for (j=0;j<3600;j++) {
			//terminalVelocity = sqrt((2.0f*weight)/(density*area*coefficient));
			S0 = weight;
			S0 *=2.0;
			S1 = density;
			S1 *= area;
			S1 *= coefficient;
			S0 /= S1;
			S0 = sqrt(S0);
			//printf("Final velocity is %f\n",terminalVelocity);
			D2 = S0;
			//dynamicPressure = 0.5*density*terminalVelocity*terminalVelocity;
			S2 = density;
			S2 *= S0;
			S2 *= S0;
			S3 = 0.5;
			S2 *= S3;
			//printf("Dynamic pressure is %f\n",dynamicPressure);
			D2 = S2;
		}
	}
	end = time(NULL);
	seconds = difftime(end,start);
	printf("time it took %f seconds\n",seconds);

	return 0;
}
