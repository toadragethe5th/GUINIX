global _start

MAGIC_NUMBER	equ 0x1BADB002
FLAGS		equ 0x0
CHECKSUM	equ -(MAGIC_NUMBER + FLAGS)

section .multiboot
align 4
	dd MAGIC_NUMBER
	dd FLAGS
	dd CHECKSUM

section .text
extern kmain
_start:
	mov esp, kernel_stack + KERN_STACKSIZE
	call kmain


loop:
	jmp loop

section .data
KERN_STACKSIZE equ 4096

section .bss
align 4
kernel_stack:
	resb KERN_STACKSIZE
