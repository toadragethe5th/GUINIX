# Makefile for GUINIX
#
# Written by Ryan Murphy

CFLAGS  = -O2 -nostdlib -ffreestanding -Wall -Wextra
CFLAGS += # -I./kernel/include/drivers 

CC      ?= gcc

<<<<<<< HEAD
ARCH   ?= x86
boot    = arch/$(ARCH)/boot/boot.s
=======
boot    = arch/x86/boot
boots   = $(boot)/boot.s
bootc   = $(boot)/kmain.c
>>>>>>> 7d6265a (Added random stuff to the makefile.)

all: boots.o bootc.o kernel.elf guinix.iso

boots.o: $(boots)
	nasm -f elf64 $< -o ./build/$@

bootc.o: $(bootc)
	$(CC) -c $< -o ./build/$@

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
