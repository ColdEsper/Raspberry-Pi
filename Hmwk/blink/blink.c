/* blink.c
	D. Thiebaut
	taken from https://www.raspberrypi.org/forums/viewtopic.php?f=33&t=23090
	blinks Physical Pin 7 On and Off, 10 times. 
	to compile and run:
	gcc -o blink blink.c -lwiringPi
	sudo ./blink 

	modified by Casey Copeland
*/

#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>

int main ( void ) {
	int pin;
	int i;
	int j;
	if (wiringPiSetup() == -1) {
		printf( "Setup didn't work... Aborting." );
		exit (1);
	}
	printf("Raspberry Pi wiringPi blink test\n");
	j=15;
	/*loop through pins to find which one blinks*/
	for (j=0;j<26;++j) {
		pin = j;
		printf("Testing pin %d\n",j);
		
		pinMode(pin, OUTPUT);
		for ( i=0; i<10; i++ ) {
			digitalWrite(pin, 0);
			delay(250);
		       	digitalWrite(pin, 1);
			delay(250);
		}
	}
	return 0;
}
