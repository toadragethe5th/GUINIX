/*
 *
 * string.c
 *
 * String manipulation utilities
 *
 * Written by Ryan Murphy (rehmurphy@gmail.com)
 *
 * GUINIX 2024
 *
 */

#include <stdint.h>
#include <stddef.h>

#include <string.h>

size_t strlen(const char *s) {
	size_t i;
	for (i=0; *s; ++s, ++i);
	return i;
}
