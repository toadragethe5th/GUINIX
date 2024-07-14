#  Makefile for GUINIX
#  Written by Ryan Murphy, 2024

all: run

kernel.bin: entry.o kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

entry.o: arch/x86/boot/entry.asm
	nasm $< -f elf -o $@

kernel.o: arch/x86/kernel/kernel.c
	gcc -m32 -ffreestanding -c $< -o $@

mbr.bin: arch/x86/boot/boot.asm
	nasm $< -f bin -o $@

guinix.bin: mbr.bin kernel.bin
	cat $^ > $@

run: guinix.bin
	qemu-system-i386 -fda $<

clean:
	$(RM) *.bin *.o *.dis
