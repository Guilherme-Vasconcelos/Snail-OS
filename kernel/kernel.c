#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <iso646.h>

#include "vga.h"
#include "string.h"

#if defined(__linux__)
#error "Do not use the system's default compiler, but rather a cross-compiler. Check setup_compiler.sh."
#endif

#if not defined(__i386__)
#error "This kernel needs to be compiled with a i386-elf compiler."
#endif

int main(void)
{
    vga_term_initialize(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
    vga_term_writestring("Snail v0.0.1");

    return 0;
}
