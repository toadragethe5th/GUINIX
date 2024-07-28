# MAKEFILE FOR GUINIX
#
# Written by Ryan Murphy

SHELL   ?= /bin/sh
CC      ?= gcc
CFLAGS  ?= -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
AS      ?= as

i686    =  arch/i686

# Include dirs

# Add more include directories as needed

.PHONY: all

all:	boots.o	bootc.o kernel.o guinix.bin

boots.o: $(i686)/boot/boot.S
	$(CC) -S  $< -o $@ -fPIE

bootc.o: $(i686)/boot/tty.c
	$(CC) -c $^ -o $@ $(CFLAGS)

kernel.o: kernel/kernel.c
	$(CC) -c -e kmain $^ -o $@ $(CFLAGS)

guinix.bin: boots.o bootc.o kernel.o
	$(CC) -T linker.ld -o $@ $(CFLAGS) $^ -lgcc

clean:
	rm *.o
	rm *.bin
