all:
	as -o div.o div.s
	ld -o div div.o
	as -o mod.o mod.s
	ld -o mod mod.o
	gcc -o divMod divMod.c
clean:
	rm div.o div mod.o mod
