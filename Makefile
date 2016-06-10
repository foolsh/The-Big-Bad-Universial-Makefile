TARGET = file-info
LIBS = -lm
CC = gcc
CFLAGS = -g -Wall

.PHONY: default all clean dump asm

default: $(TARGET)

all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)
	-rm -f *.objdump
	-rm -f *.s
	-rm -f *.out

dump:
	objdump -D -S -G -f -p $(TARGET).o > $(TARGET).objdump

asm:
	gcc -S $(TARGET).c

profile:
	gcc -pg $(TARGET).c -o $(TARGET)
