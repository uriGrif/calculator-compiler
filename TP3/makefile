cflags = -g -Wall -pedantic-errors -D_GNU_SOURCE -std=c2x

tp3parser.exe : scanner.o parser.o main.o
	gcc scanner.o parser.o main.o -o tp3parser -L/usr/lib/ -lfl

scanner.o : scanner.c scanner.h
	gcc $(cflags) -c scanner.c

scanner.c scanner.h : scanner.l parser.h
	flex scanner.l

parser.c parser.h : parser.y
	bison parser.y

parser.o : scanner.h parser.h parser.c
	gcc $(cflags) -c parser.c

main.o: main.c parser.h scanner.h
	gcc $(cflags) -c main.c

clean : 
	rm scanner.c scanner.h scanner.o main.o parser.c parser.h parser.o tp3parser.exe