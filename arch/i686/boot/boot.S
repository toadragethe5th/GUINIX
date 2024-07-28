/*
 *
 * GUINIX boot sector
 *
 *
 * Written by Ryan Murphy, 2024
 * 
 *
 */


/*
 *
 * Multiboot header
 *
 */

.set ALIGN,	1<<0
.set MEMINFO,	1<<1
.set FLAGS,	ALIGN | MEMINFO
.set MAGIC,	0x1BADB002
.set CHECKSUM,	-(MAGIC + FLAGS)

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384				# 16 KiB
stack_top:

.section .text
.global _begin				# Defined for our linker
.type _begin, @function
_begin:					# Our entry point
	mov $stack_top, %esp		# Set up a stack

	/*
	 * TODO HERE:
	 * - Load GDT
	 * - Enable Paging
	 *
	 */

	call kmain

	cli
1:	hlt
	jmp 1b

.size _begin, . - _begin
