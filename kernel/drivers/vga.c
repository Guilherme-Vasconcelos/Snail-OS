#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#include "vga.h"
#include "string.h"

/* TODO: it may make sense in the future to make a complete implementation
of stdio. However, since there are no files yet, I'll just keep using this
vga-based terminal for any kind of output. The stdio implementation in the
future will probably wrap around this vga terminal. */

static inline uint8_t vga_entry_color(enum vga_color font_color, enum vga_color backgroud_color)
{
    return font_color | backgroud_color << 4;
}

static inline uint16_t vga_entry(unsigned char c, uint8_t color)
{
    return (uint16_t)c | (uint16_t)color << 8;
}

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
static const size_t VGA_TEXT_BUFFER_ADDR = 0xB8000;

size_t vga_term_row, vga_term_column;
uint8_t vga_term_color;
uint16_t *vga_term_buffer;

void vga_term_initialize(enum vga_color font_color, enum vga_color backgroud_color)
{
    vga_term_row = 0;
    vga_term_column = 0;
    vga_term_color = vga_entry_color(font_color, backgroud_color);
    vga_term_buffer = (uint16_t *)VGA_TEXT_BUFFER_ADDR;
    for (size_t y = 0; y < VGA_HEIGHT; ++y)
    {
        for (size_t x = 0; x < VGA_WIDTH; ++x)
        {
            const size_t index = y * VGA_WIDTH + x;
            vga_term_buffer[index] = vga_entry(' ', vga_term_color);
        }
    }
}

void vga_term_setcolor(uint8_t color)
{
    vga_term_color = color;
}

void vga_term_nextline()
{
    vga_term_column = 0;
    ++vga_term_row;
}

void vga_term_horizontal_scroll()
{
    const size_t last_element_index = VGA_HEIGHT * VGA_WIDTH;
    const size_t last_element_addr = (size_t)(&(vga_term_buffer[last_element_index]));
    // FIXME: something here feels wrong, I believe it may be copying more bytes than it should
    const size_t nbytes_to_copy = last_element_addr - (size_t)vga_term_buffer;
    memmove(vga_term_buffer, &(vga_term_buffer[VGA_WIDTH]), nbytes_to_copy);
    vga_term_row = VGA_HEIGHT - 1;
}

void vga_term_put_entry_at(char c, uint8_t color, size_t x, size_t y)
{
    const size_t index = y * VGA_WIDTH + x;
    vga_term_buffer[index] = vga_entry(c, color);
}

void vga_term_putchar(char c)
{
    if (vga_term_row == VGA_HEIGHT)
    {
        vga_term_horizontal_scroll();
    }

    if (c == '\n')
    {
        /* TODO: in the future there has to be some kind of table for all possible
    chars that are not directly printed to the screen, such as \n (already implemented)
    and \t. */
        vga_term_nextline();
    }
    else
    {
        vga_term_put_entry_at(c, vga_term_color, vga_term_column, vga_term_row);
        if (++vga_term_column == VGA_WIDTH)
        {
            vga_term_nextline();
        }
    }
}

void vga_term_write(const char *data, size_t size)
{
    for (size_t i = 0; i < size; ++i)
    {
        vga_term_putchar(data[i]);
    }
}

void vga_term_writestring(const char *s)
{
    vga_term_write(s, strlen(s));
}
