CC      = gcc
LDFLAGS = -g

all: etapa2

## Etapa 2
etapa2: nico


doc: Doxyfile $(HEAD1)
	doxygen Doxyfile

nico: lex.yy.c y.tab.c tokens.h node.o main-nico.c
	$(CC) $(LDFLAGS) -Wall -o nico lex.yy.c y.tab.c main-nico.c node.o -lfl

lex.yy.c: scanner.l tokens.h
	flex scanner.l

tokens.h: y.tab.c

y.tab.c: nico.y
	bison --defines=tokens.h nico.y

node.o: node.c node.h
	$(CC) $(LDFLAGS) -Wall -c node.c

clean:
	rm -f *.o lex.yy.? y.tab.? tokens.h nico
