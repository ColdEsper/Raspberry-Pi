#include<stdio.h>

int main () {
	unsigned int value = 252;
	unsigned int divisor = 31;
	unsigned int counter = 0;
	unsigned int counterIncrement = 1;
	while (divisor <= value) {
		divisor<<=1;
		counterIncrement<<=1;
	}
	divisor>>=1;
	while (counterIncrement > 0)
	{
		if (divisor < value) {
			value-=divisor;
			counter+=counterIncrement;
		}
		divisor>>=1;
		counterIncrement>>=1;
	}
	printf("Division: %d\n",counter);
	printf("Modulus: %d\n",value);
	return 0;
}
