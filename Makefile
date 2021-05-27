# TODO: maybe use a tool such as autotools in the future instead of writing this simple Makefile manually.
# Also, another limitation currently is that kernel source files and lib source files cannot have
# the same name.

# Tools to use when assembling, compiling, linking, etc.
TOOLS_DIR := opt/cross/bin

# Where to put object and binary files
OBJ_DIR := bin

# Source code directories
KERNEL_DIR := kernel
LIB_DIR := lib
IDIR := include
BOOT_DIR := boot
LINKER_DIR := linker

# Compiler / assembler
CC := $(TOOLS_DIR)/i686-elf-gcc
ASM := $(TOOLS_DIR)/i686-elf-as

# Flags
CC_FLAGS := -ffreestanding -O2 -Wall -Wextra -I$(IDIR)
LINKER_FLAGS := -ffreestanding -O2 -nostdlib -lgcc

# Source code files
KERNEL_SRC_FILES := $(wildcard $(KERNEL_DIR)/*.c)
LIB_SRC_FILES := $(wildcard $(LIB_DIR)/*.c)

# Obj files
KERNEL_OBJ_FILES := $(KERNEL_SRC_FILES:$(KERNEL_DIR)/%.c=$(OBJ_DIR)/%.o)
LIB_OBJ_FILES := $(LIB_SRC_FILES:$(LIB_DIR)/%.c=$(OBJ_DIR)/%.o)
ALL_OBJ_FILES = $(wildcard $(OBJ_DIR)/*.o)

all: prepare assemble_boot compile_kernel compile_lib link_everything

prepare:
	mkdir -p $(OBJ_DIR)

# Step 1: assemble the multiboot header.
# For the moment it will always be located at boot/ and will be just a simple .s file.
assemble_boot: bin/boot.o
bin/boot.o: $(BOOT_DIR)/boot.s
	$(ASM) $< -o $@

# Step 2: compiling the kernel.
# All kernel files will be located at kernel/. For the moment no subdirectories will be used.
compile_kernel: $(KERNEL_OBJ_FILES)
$(OBJ_DIR)/%.o: $(KERNEL_DIR)/%.c
	$(CC) $(CC_FLAGS) -c $< -o $@

# Step 3: compiling libraries.
# All lib files will be located at lib/. For the moment no subdirectories will be used.
compile_lib: $(LIB_OBJ_FILES)
$(OBJ_DIR)/%.o: $(LIB_DIR)/%.c
	$(CC) $(CC_FLAGS) -c $< -o $@

# Step 4: linking.
# In order to link it must evoke the linker on every file present at obj/
link_everything:
	$(CC) -T $(LINKER_DIR)/linker.ld -o snail.bin $(ALL_OBJ_FILES) $(LINKER_FLAGS)
