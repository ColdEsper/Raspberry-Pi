#include<stdio.h>
#include<math.h>

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

	area = (diameter*diameter*PI)/4.0f;
	terminalVelocity = sqrt((2.0f*weight)/(density*area*coefficient));
	printf("Final velocity is %f\n",terminalVelocity);
	dynamicPressure = 0.5*density*terminalVelocity*terminalVelocity;
	printf("Dynamic pressure is %f\n",dynamicPressure);

	return 0;
}
