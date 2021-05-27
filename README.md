# Snail
Snail is a tiny operating system made from scratch for leaning purposes.

### Setup
1. Pre-requisites: your system should be able to build a modern version of
GCC and GNU Binutils. Check which exact versions are being used at `setup_compiler.sh`.
If you cannot build these versions, try changing them to older values (you can find a list
of successful builds [here](https://wiki.osdev.org/Cross-Compiler_Successful_Builds)).

2. At the root of the project execute `setup_compiler.sh` (keep in mind this will take a
while to finish). The script will download and compile binutils and a cross-platform GCC,
which is required until Snail (if it ever) can evoke a compiler on its own. The new binaries
will be available at <snail_root_dir>/opt/cross/bin,

3. After the build finishes, optionally run `export PATH="<SNAIL_ROOT_DIR>/opt/cross/bin:$PATH"`
to add the new GCC to your path for the current session, which can be useful for small tests,
but probably not required since the Makefile will already use the correct compiler.

4. Run `make` to compile Snail. This will generate a `snail.bin` file.

5. Boot the bin file into QEMU with `qemu-system-i386 -kernel snail.bin`

6. Alternatively to step 5, you can use grub-mkrescue to generate a `.iso` file and then
boot the file into QEMU with `qemu-system-i386 -cdrom snail.iso`. More instructions on how to
use grub-mkrescue can be found [here](https://wiki.osdev.org/Bare_Bones#Building_a_bootable_cdrom_image).

### Acknowledgements

I have been learning a lot with [OSDev Wiki](https://wiki.osdev.org/Main_Page) and used
a lot of the resources there. Check it out, it's definitely a great place to start!

### License
Snail is licensed under the GNU General Public License, either version 3 or any later versions.
Please refer to LICENSE for more details.
