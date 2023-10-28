cflags = -g -Wall -pedantic-errors -D_GNU_SOURCE -std=c2x

scanner.exe : scanner.o main.o
	gcc scanner.o main.o -o scanner -L/usr/lib/ -lfl

scanner.o : scanner.c scanner.h
	gcc $(cflags) -c scanner.c

scanner.c scanner.h : scanner.l tokens.h
	flex scanner.l

main.o: main.c tokens.h scanner.h
	gcc $(cflags) -c main.c

clean : 
	rm scanner.c scanner.h scanner.o main.o scanner.exe