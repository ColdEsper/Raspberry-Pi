all:
	gcc -o hello hello01.s
	gcc -o printf printf01.s
	gcc -g -c -o multiply5.o multiply5.s
	gcc -g -o printf2 printf02.s multiply5.o
clean:
	rm hello printf printf2
