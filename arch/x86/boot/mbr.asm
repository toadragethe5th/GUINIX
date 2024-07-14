;; boot.s
;; Ryan Murphy, 2024
;; boot sector for GUINIX
;; Written in x86 Intel because 
;; I don't know x86 Solaris.
;;
;; Naturally, as a OS dev I only
;; know about 95% of what this code
;; does. Enjoy!

MBALIGN  equ 1 << 0
MEMINFO  equ 1 << 1
MBFLAGS  equ MBALIGN | MEMINFO
MAGIC    equ 0x1BADB002
CHECKSUM equ -(MAGIC + MBFLAGS)

section .multiboot
align 4
	dd MAGIC
	dd MBFLAGS
	dd CHECKSUM

[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

mov bp, 0x9000			;; Setup stack
mov sp, bp

call load_kernel
call 32bit			;; NASM calls a syntax error here, fix

jmp $				;; Hang


disk_load:
        pusha
        push dx

        mov ah, 0x02		;; Read mode
        mov al, dh		;; number of sectors to read
        mov cl, 0x02		;; Start from S2
        mov ch, 0x00		;; C0
        mov dh, 0x00		;; H0
        int 13h			;; 

        jc DISK_ERROR

        pop dx
        cmp al, dh
        jne SECTORS_ERROR
        popa
        ret

DISK_ERROR:
        call err_header 
	mov al, '0'
	push al

        jmp DISK_LOOP


err_header:
	xor ax, ax
	mov ah, 0x0e
	mov al, '0'
	int 10h

	mov al, 'x'
	int 10h
	xor al, al

	ret

;; GDT table related code
gdt_start:			;; GDT table
	dq 0x0000		;; Null descriptor
gdt_code:			;; Code descriptor
	dw 0xffff		;; Segment length
	dw 0x0000
	db 0x0000
	db 0x009a
	db 0x00cf
	db 0x0000
gdt_data:
	dw 0xffff
	dw 0x0000
	db 0x0000
	db 0x0092
	db 0x00cf
	db 0x0000
gdt_end:
gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

[bits 16]

%include "boot/err.asm"

[bits 16]
load_kernel:
	mov bx, KERNEL_OFFSET
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
BEGIN_32BIT:
	call KERNEL_OFFSET
	jmp $

BOOT_DRIVE db 0

times 510 - ($ - $$) db 0
dw 0xaa55
