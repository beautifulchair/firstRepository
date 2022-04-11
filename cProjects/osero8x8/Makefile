# CC = gcc
# CFLAGS = -Wall -g -O2
# STD = -std=c99
NAME = available board otherfunc putImfo record
DEPS = $(NAME:%=hs/%.h)
OBJ = $(NAME:%=objs/%.o)
TARGET = mosero rMatch tamesi sortResultsByRecord

all: $(TARGET)

mosero: mosero.c $(OBJ)
	gcc -Wall -O2 -o mosero $(OBJ) mosero.c

rMatch: rMatch.c $(OBJ)
	gcc -Wall -O2 -o rMatch $(OBJ) rMatch.c

tamesi: tamesi.c $(OBJ)
	gcc -Wall -O2 -o tamesi $(OBJ) tamesi.c

sortResultsByRecord: sortResultsByRecord.c
	gcc -Wall -O2 -o sortResultsByRecord sortResultsByRecord.c

objs/%.o: %.c $(DEPS)
	gcc -Wall -O2 -c $< -o $@

.PHONY: clean
clean:
	rm -f *.o objs/* $(TARGET)