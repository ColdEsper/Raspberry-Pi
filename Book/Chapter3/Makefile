all:
	as -o prog3a.o prog3a.s
	ld -o prog3a prog3a.o
	as -o prog3b.o prog3b.s
	as -o prog3c.o prog3c.s
	ld -o prog3b prog3b.o prog3c.o
clean:
	rm prog3a.o prog3a prog3b.o prog3c.o prog3b
