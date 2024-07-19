# MAKEFILE FOR GUINIX
#
# Written by Ryan Murphy

SHELL   ?= /bin/sh
CC      ?= gcc
CFLAGS  ?= -m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra
AS      ?= as

i686    =  arch/i686

kernel  = kernel

# Include dirs
INCLUDEDIR  = include

all:
	run

boot.o: $(i686)/boot/boot.S
	as $< -o $@

kernel.o: $(kernel)/kernel.c
	$(CC) -c $< -o $@ $(CFLAGS)


