#include<stdio.h>

const float PI = 22.0/7.0;
const float MONTHS_PER_YEAR = 12.0;


int main () {
	printf("For %d months, there are %d years\n",88,(unsigned char)(88.0/MONTHS_PER_YEAR));
	printf("For circle area %d, radius squared is %d\n",110,(unsigned char)(110/PI));
	printf("For circle area %f, radius squared is %d\n",113.4,(unsigned char)(113.4/PI));
	printf("For radius %d, area is %d\n",6,(unsigned char)(6*6*PI));
	printf("For radius %f, area is %d\n",6.5,(unsigned char)(6.5*6.5*PI));
	return 0;
}
