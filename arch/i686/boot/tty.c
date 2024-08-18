/*
 * TTY routines for GUINIX
 *
 * Ryan Murphy, 2024
 *
 */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <tty.h>
// The stdlib doesn't exist; while stdbool/stddef/stdint just define things,
// string.h actually links functions that don't exist
// #include <string.h>

#include "vga.h"

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
static uint16_t* const VMEM = (uint16_t*) 0xb8000;

static size_t terminal_row;
static size_t terminal_column;
static uint8_t terminal_color;
static uint16_t* terminal_buffer;

ptrdiff_t strlen(char const *string) {
	long out = 0;
	while(*string++) out++;
	return out;
}

/*
 *
 * TERMINAL COLORS
 *
 * enum vga_color {
 *	VGA_COLOR_BLACK = 0,
 *      VGA_COLOR_BLUE = 1,
 *	VGA_COLOR_GREEN = 2,
 *	VGA_COLOR_CYAN = 3,
 *	VGA_COLOR_RED = 4,
 *	VGA_COLOR_MAGENTA = 5,
 *	VGA_COLOR_BROWN = 6,
 * 	VGA_COLOR_LIGHT_GREY = 7,
 * 	VGA_COLOR_DARK_GREY = 8,
 *	VGA_COLOR_LIGHT_BLUE = 9,
 *	VGA_COLOR_LIGHT_GREEN = 10,
 *	VGA_COLOR_LIGHT_CYAN = 11,
 *	VGA_COLOR_LIGHT_RED = 12,
 *	VGA_COLOR_LIGHT_MAGENTA = 13,
 *	VGA_COLOR_LIGHT_BROWN = 14,
 *	VGA_COLOR_WHITE = 15,
 * };
 *
 */

void terminal_initialize(void)
{

	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
	terminal_buffer = VMEM;

	for (size_t y = 0; y < VGA_HEIGHT; y++)
	{

		for (size_t x = 0; x < VGA_WIDTH; x++)
		{

			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);

		}
	
	}

}

void terminal_setcolor(uint8_t color)
{

	terminal_color = color;

}

/*
 *
 * Write char c to index at [x,y]
 *
 */
void terminal_putentryat(unsigned char c, uint8_t color, size_t x, size_t y)
{

	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);

}

/*
 *
 * Simply write a char to the current position on screen.
 *
 */
void terminal_putchar(char c)
{

	unsigned char uc = c;
	terminal_putentryat(uc, terminal_color, terminal_column, terminal_row);

	if (++terminal_column == VGA_WIDTH)
	{

		terminal_column = 0;

		if (++terminal_row == VGA_HEIGHT)
		{

			terminal_row = 0;

		}
	
	}

}



void terminal_write(const char* data, size_t size)
{

	for (size_t i = 0; i < size; i++)
	{

		terminal_putchar(data[i]);

	}

}

void terminal_writestring(const char* string)
{

	terminal_write(string, strlen(string));

}
