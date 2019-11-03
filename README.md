# avrd

Ported defines of avr-gcc and headers of avr-libc.

Enables you to use D with -betterC on embedded devices.

## Port Status

Not all device specific header files are ported yet. When trying to import avr.io for the default device names this will result in an error in avr.io for any unported device.

Ported board headers:

- ATmega1284P
- ATmega168P
- ATmega328P

## Project structure

Most includes you would find in avr-libc (`#include <avr/io.h>` for example) have the same naming convention with this D package. So `import avr.io;` for your basic io header file.

You cannot currently use any custom processor definitions with the avr.io module.

Instead of defines like in avr-gcc this package defines enum values from the module `avr.specs` which describe the features of the processor. It's using enums instead of version statements so static if can be used with them, combined, etc. and also throws compiler errors if misspelling such a name.

The following defines are ported as enums:

```d
/// Architecture automatically determined by the device name
/// This does not take into account the mmcu parameter and is solely based on the 
enum __AVR_ARCH__ = 2;

/// Assembler only
enum __AVR_ASM_ONLY__ = true;

/// Core have 'MUL*' instructions
enum __AVR_HAVE_MUL__ = true;
/// same value, but obsolete
enum __AVR_ENHANCED__ = true;

/// Core have 'CALL' and 'JMP' instructions
enum __AVR_HAVE_JMP_CALL__ = true;
/// same value, but obsolete
enum __AVR_MEGA__ = true;

/// Core have 'MOVW' and 'LPM Rx,Z' instructions
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true; /// ditto

/// Core have 'ELPM' instructions
enum __AVR_HAVE_ELPM__ = true;

/// Core have 'EICALL' and 'EIJMP' instructions
enum __AVR_HAVE_ELPMX__ = true;

/// Core have 'EICALL' and 'EIJMP' instructions
enum __AVR_HAVE_EIJMP_EICALL_ = true;
/// This also means this device has support for more than 128 KiB of program memory. This means that the program counter (PC) is 3 bytes wide
enum __AVR_3_BYTE_PC__ = true;

/// The program counter (PC) is 2 bytes wide. This is the case for devices with up to 128 KiB of program memory
enum __AVR_2_BYTE_PC__ = true;

/// This is an XMEGA core
enum __AVR_XMEGA__ = true;

/// This core has the RAMPD special function register
/// and thus also the RAMPX, RAMPY and RAMPZ registers.
enum __AVR_HAVE_RAMPD__ = true;
enum __AVR_HAVE_RAMPX__ = true;
enum __AVR_HAVE_RAMPY__ = true;
enum __AVR_HAVE_RAMPZ__ = true;

/// This is a TINY core
enum __AVR_TINY__ = true;

/// Offset where flash memory is seen in RAM address range or 0
/// NOTE: on avr-gcc this value is not set when __AVR_TINY__ is set, but instead it is named __AVR_TINY_PM_BASE_ADDRESS__
/// in avrd it is always called __AVR_PM_BASE_ADDRESS__ and trying to use the TINY version will not find the symbol
enum __AVR_PM_BASE_ADDRESS__ = 0;

/// Instructions that can address I/O special function registers directly like IN, OUT, SBI, etc. may use a different address as if addressed by an instruction to access RAM like LD or STS. This offset depends on the device architecture and has to be subtracted from the RAM address in order to get the respective I/O address
enum __AVR_SFR_OFFSET__ = 32;
```

See also [GCC AVR Options](https://gcc.gnu.org/onlinedocs/gcc-4.7.4/gcc/AVR-Options.html) for more detailed explanation of the here available values.

These specs are available from `avr.specs` but are also publicly imported by `avr.io`.

Additionally there is a `__AVR_DEVICE_NAME__` value which is a string name of the currently used processor.

Device specific defines on the other hand are defined as version values. So far for most devices this is only the device name itself for C compatibility such as:

```d
version (__AVR_ATmega1284P__)
{
	// on ATmega1284P
}
```

## Installing LDC compatible with AVR

First follow https://wiki.dlang.org/Building_LDC_from_source additionally to using cmake on llvm with `-DLLVM_TARGETS_TO_BUILD="AVR"`

```
wget http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz
tar xvf llvm-9.0.0.src.tar.xz
rm llvm-9.0.0.src.tar.xz

mkdir build-llvm && cd build-llvm # using a fresh new build dir is highly recommended whenever re-invoking CMake
cmake -G Ninja ../llvm-9.0.0.src \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/../install-llvm \
  -DLLVM_BINUTILS_INCDIR=/usr/include \
  -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD='AVR' \
  -DLLVM_TARGETS_TO_BUILD='AArch64;ARM;Mips;MSP430;NVPTX;PowerPC;RISCV;WebAssembly;X86' \
  -DCOMPILER_RT_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_TESTS=OFF
ninja
ninja install


cd ..
git clone --recursive https://github.com/ldc-developers/ldc.git

mkdir build-ldc && cd build-ldc
cmake -G Ninja ../ldc \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/../install-ldc \
  -DLLVM_ROOT_DIR=$PWD/../install-llvm
ninja
ninja install
```

You now have a folder called install-ldc with the ldc2 binaries with AVR target enabled. Use this ldc2 binary with the `--compiler=path/to/ldc2` switch to make dub use this for compilation.
