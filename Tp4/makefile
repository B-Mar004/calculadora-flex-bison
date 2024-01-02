CC=gcc
CFLAGS=-g -Wall -Winvalid-pch
LDFLAGS=-L/C:/msys64/usr/lib
LIBS=-lfl -lm

calculadora.exe : scanner.c parser.c 
	$(CC) $(CFLAGS) calc.c scanner.c parser.c main.c -o calculadora.exe $(LDFLAGS) $(LIBS) 

parser.c parser.h : scanner.c scanner.h
	bison parser.y

scanner.c scanner.h : scanner.l
	flex scanner.l
clean:
	rm -f scanner.c  scanner.h parser.c parser.h *.o calculadora.exe

