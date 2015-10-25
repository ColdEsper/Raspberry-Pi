/* File for inclusion to make symbols available to assembler
 (.global is for making symbols available to linker) */

/* STRUCTURES 
---------------------------------*/
/* coordinate structure 
	1 word X
	1 word Y*/
sizeOfCoord=8
/* stats structure
	1 word HP
	1 word Attack */
sizeOfStats=8
/* battler structure layout
   1 stats 
   1 coordinate position*/
sizeOfBattler=sizeOfStats+sizeOfCoord
