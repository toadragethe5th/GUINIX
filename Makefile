# Makefile for GUINIX
#
# Written by Ryan Murphy

CFLAGS  = -O2 -nostdlib -ffreestanding -Wall -Wextra
CFLAGS += -I \
	  -I 

CC      = gcc

boot    = arch/x86/boot/boot.s

all: boots.o kernel.elf guinix.iso

boots.o: $(boot)
	nasm -f elf64 $< -o ./build/$@

kernel.elf: $(wildcard ./build/*.o)
	ld -T linker.ld -melf_x86_64 $< -o ./build/$@
	cp ./build/$@ ./iso/boot/$@

guinix.iso:
	grub-mkrescue -o $@ ./iso

clean:
	rm -f $(wildcard ./build/*.o)
	rm -f $(wildcard ./build/*.elf)
	rm -f ./iso/boot/kernel.elf
	rm -f guinix.iso
