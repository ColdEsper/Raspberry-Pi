all:
	as -o if.o if.s
	ld -o if if.o
	as -o case.o case.s
	ld -o case case.o
	as -o ifelse.o ifelse.s
	ld -o ifelse ifelse.o
	gcc -o conditionals conditionals.c
clean:
	rm if if.o case case.o ifelse ifelse.o
