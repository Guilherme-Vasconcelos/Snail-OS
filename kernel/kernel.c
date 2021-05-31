#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <iso646.h>

#include "vga.h"
#include "string.h"

#if defined(WIN32) or defined(_WIN32) or defined(__WIN32__) \
    or defined(__NT__) or defined(__APPLE__) or defined(__linux__)
#error "Do not use the system's default compiler, but rather a cross-compiler. Check setup_compiler.sh."
#endif

#if not defined(__i386__)
#error "This kernel needs to be compiled with a i386-elf compiler."
#endif

int main(void)
{
    vga_term_initialize(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
    vga_term_writestring(
        "Snail v0.0.1\n"
        "Copyright (c) Guilherme-Vasconcelos\n\n"
        "Snail is free software licensed under "
        "the GNU General Public License, either\n"
        "version 3 or any later versions.\n"
        "Check it out: https://github.com/Guilherme-Vasconcelos/Snail-OS\n"
    );

    return 0;
}
