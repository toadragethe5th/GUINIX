/*
 *
 * Main Kernel File
 *
 * GUINIX, 2024
 *
 * Written by Ryan Murphy
 *
 */

/*
 *
 * Kernel-based headers
 *
 */
#include <tty.h>


/*
 *
 * Main function as declared in boot.S
 *
 */
void main(void)
{

	terminal_initialize();
	terminal_writestring("Succesfully loaded kernel.\n");

}
