/*
 *
 * GUINIX boot sector
 *
 *
 * Written by Ryan Murphy, 2024
 * 
 *
 */

.set ALIGN,	1<<0
.set MEMINFO,	1<<1
.set FLAGS,	ALIGN | MEMINFO
.set MAGIC,	0x1BADB002
.set CHECKSUM,	-(MAGIC + FLAGS)
