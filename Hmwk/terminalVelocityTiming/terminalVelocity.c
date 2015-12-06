#include<stdio.h>
#include<math.h>
#include<time.h>

#define PI 3.1415926535897932

/* For problem:
 * diameter = 0.14 ft
 * weight = .10125 lbs
 * coefficient of drag = .5
 * density of air = .0023679
 */

int main () {
	float diameter = 0.14;
	float weight = 0.10125;
	float coefficient = 0.5;
	float density = 0.0023679;
	float terminalVelocity;
	float dynamicPressure;
	float area;

	time_t end;
	double seconds;
	unsigned int i;
	unsigned int j;
	time_t start = time(NULL);
	for (i=0;i<65535;++i) {
		for (j=0;j<3600;j++) {
		area = (diameter*diameter*PI)/4.0f;
		terminalVelocity = sqrt((2.0f*weight)/(density*area*coefficient));
		dynamicPressure = 0.5*density*terminalVelocity*terminalVelocity;
		}
	}
	end = time(NULL);
	seconds = difftime(end,start);
	printf("time it took %f seconds\n",seconds);

	return 0;
}
