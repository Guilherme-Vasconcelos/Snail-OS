#include <stddef.h>

#include "string.h"

size_t strlen(const char *string)
{
    size_t len = 0;
    while (string[len] != '\0')
    {
        ++len;
    }

    return len;
}

void *memmove(void *dest, const void *src, size_t n)
{
    // FIXME: could these casts possibly cause issues in the future?
    size_t *tmp_dest = (size_t *)dest;
    size_t *tmp_src = (size_t *)src;

    // If dest and src are overlapping, directly overwriting dest could
    // make src possibly lose important data that it shouldn't lose yet
    // hence why use the tmp buffer.
    size_t tmp[n];

    for (size_t i = 0; i < n; ++i)
    {
        tmp[i] = tmp_src[i];
    }

    for (size_t i = 0; i < n; ++i)
    {
        tmp_dest[i] = tmp[i];
    }

    dest = tmp_dest;
    return (void *)dest;
}
