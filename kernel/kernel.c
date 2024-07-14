/*
 * Main kernel file
 *
 * Written by Ryan Murphy
 *
 */

/*
 * 
 * Currently a dummy kernel.
 *
 */
void main()
{

	char* vmem = (char*) 0xb8000;
	*vmem = 'x';

}


