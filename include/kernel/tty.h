#ifndef KERNEL_TTY_H
#define KERNEL_TTY_H

/*
 *
 * KERNEL_TTY_H
 *
 * TTY routine header.
 *
 * Defined in:
 * 	kernel/arch/i686/boot/tty.c
 *
 * Written by Ryan Murphy.
 *
 */

#include <stddef.h>


/*
 *
 * Terminal initialization functions
 *
 */
void terminal_initialize(void);
void terminal_setcolor(uint8_t color);

/*
 *
 * Terminal writing functions
 *
 */
void terminal_putentryat(unsigned char c, uint8_t color, size_t x, size_t y);
void terminal_putchar(char c);
void terminal_write(const char* data, size_t size);
void terminal_writestring(const char* string);

#endif
