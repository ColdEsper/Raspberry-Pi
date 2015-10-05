#include<stdio.h>

int main () {
	int sumEnd = 10;
	int whileSum = 0;
	int doSum = 0;
	int forSum = 0;

	int counter = 0;
	while (counter<=sumEnd) {
		whileSum+=counter;
		counter++;
	}
	counter = 0;
	do {
		doSum+=counter;
		counter++;
	} while (counter<=sumEnd);
	for (counter=0;counter<=sumEnd;++counter) {
		forSum+=counter;
	}
	
	printf("while %d\n",whileSum);
	printf("do %d\n",doSum);
	printf("for %d\n",forSum);
	return 0;
}
