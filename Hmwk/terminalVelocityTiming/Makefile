all:
	as -o mod.o mod.s
	as -o div.o div.s
	gcc -o cscaledTerminalVelocity scaledTerminalVelocity.c -lm
	gcc -o cterminalVelocity terminalVelocity.c -lm
	gcc -o cnewtonScaledVelocity newtonScaledVelocity.c 
	gcc -o scaledPseudoAsm scaledPseudoAsm.c
	gcc -g -o newtonScaledVelocity newtonScaledVelocity.s mod.o div.o
	gcc -o floatPseudoAsm floatPseudoAsm.c -lm
	gcc -g -o terminalVelocity terminalVelocity.s

