#include <stddef.h>

#include "string.h"

/**
 * calculates the length of a string.
 * @param string a valid null-terminated string.
 * @return the length of the string.
 */
size_t strlen(const char *string)
{
    size_t len = 0;
    while (string[len] != '\0')
    {
        ++len;
    }

    return len;
}
