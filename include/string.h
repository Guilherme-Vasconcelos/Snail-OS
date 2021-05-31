#ifndef STRING_H
#define STRING_H

#include <stddef.h>

/**
 * calculates the length of a string.
 * @param string a valid null-terminated string.
 * @return the length of the string.
 */
size_t strlen(const char *string);

/**
 * copies n bytes, starting at src, into dest.
 * @param dest starting location for new bytes.
 * @param src starting location from which n bytes will be taken.
 * @return pointer to dest, in which new data will have been copied.
 */
void *memmove(void *dest, const void *src, size_t n);

#endif /* STRING_H */
