# Snail
Snail is (aims to be) a tiny operating system.

### Setup
1. Pre-requisites: your system should be able to build a modern version of
GCC and GNU Binutils. Check which exact versions are being used at `setup_compiler.sh`.
If you cannot build these versions, try changing them to older values.

2. At the root of the project execute `setup_compiler.sh`. This script will download and
compile binutils and a cross-platform GCC, which is required until Snail (if it ever) can evoke
a compiler on its own. The new binaries will be available at <snail_root_dir>/opt/cross/bin

3. After the build finishes, optionally run `export PATH="<SNAIL_ROOT_DIR>/opt/cross/bin:$PATH"`
to add the new GCC to your path for the current session.

4. Run `make` to compile the software and it will generate a `snail.bin` file.

5. Boot the bin file into QEMU with `qemu-system-i386 -kernel snail.bin`

### Acknowledgements

I have been learning a lot with [OSDev Wiki](https://wiki.osdev.org/Main_Page) and used
a lot of the resources there. Check it out, it's definitely a great place to start!

### License
Snail is licensed under the GNU General Public License, either version 3
or any later versions. Please refer to LICENSE for more details.
