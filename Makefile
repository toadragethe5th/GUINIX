# MAKEFILE FOR GUINIX
#
# Written by Ryan Murphy

SHELL   ?= /bin/sh
CC      ?= gcc
CFLAGS  ?= -std=gnu99 -ffreestanding -O2 -Wall -Wextra \
	   -I./include/drivers \
	   -I./include/libc
AS      ?= as

LIBC    := $(wildcard ./libc/*.c)
i686    =  arch/i686

# Include dirs

# Add more include directories as needed

.PHONY: all

all:	boots.o	libc.o bootc.o kernel.o guinix.bin guinix.iso run 

boots.o: $(i686)/boot/boot.S
	$(CC) -c  $< -o $@

libc.o: $(LIBC)
	$(CC) -c $^ -o $@ $(CFLAGS)

bootc.o: $(i686)/boot/tty.c
	$(CC) -c $^ -o $@ $(CFLAGS)

kernel.o: kernel/kernel.c
	$(CC) -c $^ -o $@ $(CFLAGS)

guinix.bin: boots.o bootc.o kernel.o
	$(CC) -T linker.ld -o $@ $(CFLAGS) -no-pie -nostdlib $^ -lgcc

guinix.iso: guinix.bin
	cp $< iso/boot/guinix.bin 
	grub-mkrescue -o $@ iso
	chmod 777 *.iso

run: guinix.iso
	qemu-system-i386 -cdrom $<
clean:
	rm *.o
	rm *.bin
	rm -f iso/boot/guinix.bin
	rm *.iso
