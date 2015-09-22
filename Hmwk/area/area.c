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
/*int main () {
	float val = 1.0f/12.0f;
	unsigned int* valPtr = (int *)(&val);
	*valPtr<<=24;
	const unsigned int MONTHS_PER_YEAR = *valPtr;
	val = 22.0f/7.0f;
	*valPtr<<=24;
	const unsigned int PI = *valPtr;
	val = 22.0f/7.0f;
	*valPtr<<=16;
	const unsigned short TWO_BYTE_PI = (unsigned short)(*valPtr);
	val = 7.0f/22.0f;
	*valPtr<<=24;
	const unsigned int DIV_PI = *valPtr;
	val = 7.0f/22.0f;
	*valPtr<<=16;
	const unsigned short TWO_BYTE_DIV_PI = (unsigned short)(*valPtr);
	unsigned char byteInput = 88;
	val = 113.4;
	*valPtr<<=8;
	unsigned int twoByteInput = *valPtr;
	printf("%d",MONTHS_PER_YEAR);
	printf("For %d months, there are %d years\n",88,(unsigned char)((byteInput*MONTHS_PER_YEAR)>>24));
	byteInput = 110;
	printf("For circle area %d, radius squared is %d\n",110,(unsigned char)((byteInput*DIV_PI)>>24));
	printf("For circle area %f, radius squared is %d\n",113.4,(unsigned char)((twoByteInput*TWO_BYTE_DIV_PI)>>24));
	printf("For radius %d, area is %d\n",6,(unsigned char)((byteInput*byteInput*PI)>>24));
	val = 6.5;
	*valPtr<<8;
	twoByteInput = val;
	printf("For radius %f, area is %d\n",6.5,(unsigned char)((twoByteInput*twoByteInput*TWO_BYTE_PI)>>24));
	return 0;
}*/
