#ifndef VGA_H
#define VGA_H

enum vga_color
{
    VGA_COLOR_BLACK,
    VGA_COLOR_BLUE,
    VGA_COLOR_GREEN,
    VGA_COLOR_CYAN,
    VGA_COLOR_RED,
    VGA_COLOR_MAGENTA,
    VGA_COLOR_BROWN,
    VGA_COLOR_LIGHT_GREY,
    VGA_COLOR_DARK_GREY,
    VGA_COLOR_LIGHT_BLUE,
    VGA_COLOR_LIGHT_GREEN,
    VGA_COLOR_LIGHT_CYAN,
    VGA_COLOR_LIGHT_RED,
    VGA_COLOR_LIGHT_MAGENTA,
    VGA_COLOR_LIGHT_BROWN,
    VGA_COLOR_WHITE
};

/**
 * Initializes vga_term to be used with the given colors.
 * @param font_color font color for vga term characters
 * @param background_color background color for vga term characters
 */
void vga_term_initialize(enum vga_color font_color, enum vga_color backgroud_color);

/**
 * Writes a string to the vga terminal.
 * @param s string to be written to vga terminal.
 */
void vga_term_writestring(const char *s);

#endif /* VGA_H */
