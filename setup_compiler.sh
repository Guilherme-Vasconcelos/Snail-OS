#!/bin/sh

# Optional flags:
# --no-download: skip the downloads.
# --no-verify: skip the signature verification.
# --no-uncompress: skip the tars uncompression.
# --no-binutils: skip binutils build.
# --no-gcc: skip gcc build.

# Acknowledgements:
# Thanks OSDev wiki for the build instructions: https://wiki.osdev.org/GCC_Cross-Compiler

# Check successful builds at: https://wiki.osdev.org/Cross-Compiler_Successful_Builds
readonly GCC_VERSION=10.2.0
readonly BINUTILS_VERSION=2.36.1

#####################################################################################

readonly PROJ_ROOT_DIR="$(pwd)"
readonly TMP_DIR="${PROJ_ROOT_DIR}/tmp"
readonly OPT_DIR="${PROJ_ROOT_DIR}/opt"
readonly CROSS_DIR="${OPT_DIR}/cross"

readonly GCC_FILE="gcc-${GCC_VERSION}"
readonly BINUTILS_FILE="binutils-${BINUTILS_VERSION}"

readonly GCC_TAR="${GCC_FILE}.tar.gz"
readonly BINUTILS_TAR="${BINUTILS_FILE}.tar.gz"

readonly SRC_GCC="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/${GCC_TAR}"
readonly SRC_BINUTILS="https://ftp.gnu.org/gnu/binutils/${BINUTILS_TAR}"

readonly SIG_GCC="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz.sig"
readonly SIG_BINUTILS="https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.gz.sig"
readonly GNU_KEYRING="https://ftp.gnu.org/gnu/gnu-keyring.gpg"

mkdir -p "${TMP_DIR}"
cd "${TMP_DIR}"

## Download packages to TMP_DIR
if [[ $* != *--no-download* ]]
then
   FILES_SOURCES=( "${SRC_GCC}" "${SRC_BINUTILS}" "${SIG_GCC}" "${SIG_BINUTILS}" "${GNU_KEYRING}" )
   for FILE_SOURCE in "${FILES_SOURCES[@]}"
   do
       wget "${FILE_SOURCE}"
   done
fi

## Verify signatures: https://gnupg.org/download/integrity_check.html
if [[ $* != *--no-verify* ]]
then
    gpg --verify --keyring ./gnu-keyring.gpg "${GCC_TAR}.sig"
    gpg --verify --keyring ./gnu-keyring.gpg "${BINUTILS_TAR}.sig"
fi

echo
echo
echo -n "Proceed to build the sources? [y/N] "
read proceed_choice
if [[ ! "$proceed_choice" =~ ^[Yy] ]]
then
    echo "Setup canceled." && exit 1
fi

## Building
if [[ $* != *--no-uncompress* ]]
then
    echo "Uncompressing tars..."
    tar -xf "${GCC_TAR}"
    tar -xf "${BINUTILS_TAR}"
fi

mkdir -p "${CROSS_DIR}"

export PREFIX="${CROSS_DIR}"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

echo "Building binutils"
if [[ $* != *--no-binutils* ]]
then
    mkdir build-binutils
    cd build-binutils
    ../binutils-${BINUTILS_VERSION}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
    make
    make install
fi

echo "Building GCC"
if [[ $* != *--no-gcc* ]]
then
    cd "${TMP_DIR}"
    mkdir build-gcc
    cd build-gcc
    ../gcc-${GCC_VERSION}/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c --without-headers
    make all-gcc
    make all-target-libgcc
    make install-gcc
    make install-target-libgcc
fi

echo "Congratulations! Everything is ready. You can remove ${TMPDIR} if you want."
