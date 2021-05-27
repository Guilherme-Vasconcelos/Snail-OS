# TODO: use a tool such as autotools instead of writing this Makefile manually.
# This is just for testing for now.

# Tools to use when assembling, compiling, linking, etc.
TOOLS_DIR := opt/cross/bin

# Where to put object and binary files
OBJ_DIR := bin
SNAIL_FINAL_DIR := snail

# Source code directories
BOOT_DIR := boot
KERNEL_DIR := kernel
LINKER_DIR := linker

CC := $(TOOLS_DIR)/i686-elf-gcc
ASM := $(TOOLS_DIR)/i686-elf-as

CC_FLAGS := -std=gnu99 -ffreestanding -O2 -Wall -Wextra

all: assemble_boot compile_kernel link_everything

assemble_boot:
	mkdir -p $(OBJ_DIR)
	$(ASM) $(BOOT_DIR)/boot.s -o $(OBJ_DIR)/boot.o

compile_kernel:
	$(CC) -c $(KERNEL_DIR)/kernel.c -o $(OBJ_DIR)/kernel.o $(CC_FLAGS)

link_everything:
	$(CC) -T $(LINKER_DIR)/linker.ld -o $(OBJ_DIR)/snail.bin -ffreestanding -O2 -nostdlib $(OBJ_DIR)/boot.o $(OBJ_DIR)/kernel.o -lgcc
