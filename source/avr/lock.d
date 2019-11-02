/**
	Lockbit Support

	Introduction:

	The Lockbit API allows a user to specify the lockbit settings for the 
	specific AVR device they are compiling for. These lockbit settings will be 
	placed in a special section in the ELF output file, after linking.

	Programming tools can take advantage of the lockbit information embedded in
	the ELF file, by extracting this information and determining if the lockbits
	need to be programmed after programming the Flash and EEPROM memories.
	This also allows a single ELF file to contain all the
	information needed to program an AVR. 

	To use the Lockbit API, include the `avr.io` module, which in turn
	automatically includes the individual I/O header file and the `avr.lock`
	module. These other two files provides everything necessary to set the AVR
	lockbits.
	
	\par Lockbit API
	
	Each I/O header file may define up to 3 macros that controls what kinds
	of lockbits are available to the user.
	
	If __LOCK_BITS_EXIST is defined, then two lock bits are available to the
	user and 3 mode settings are defined for these two bits.
	
	If __BOOT_LOCK_BITS_0_EXIST is defined, then the two BLB0 lock bits are
	available to the user and 4 mode settings are defined for these two bits.
	
	If __BOOT_LOCK_BITS_1_EXIST is defined, then the two BLB1 lock bits are
	available to the user and 4 mode settings are defined for these two bits.

	If __BOOT_LOCK_APPLICATION_TABLE_BITS_EXIST is defined then two lock bits
	are available to set the locking mode for the Application Table Section 
	(which is used in the XMEGA family).
	
	If __BOOT_LOCK_APPLICATION_BITS_EXIST is defined then two lock bits are
	available to set the locking mode for the Application Section (which is used
	in the XMEGA family).
	
	If __BOOT_LOCK_BOOT_BITS_EXIST is defined then two lock bits are available
	to set the locking mode for the Boot Loader Section (which is used in the
	XMEGA family).

	The AVR lockbit modes have inverted values, logical 1 for an unprogrammed 
	(disabled) bit and logical 0 for a programmed (enabled) bit. The defined 
	macros for each individual lock bit represent this in their definition by a 
	bit-wise inversion of a mask. For example, the LB_MODE_3 macro is defined 
	as:

	---
	#define LB_MODE_3  (0xFC)
	---
	
	To combine the lockbit mode macros together to represent a whole byte,
	use the bitwise AND operator, like so:

	---
	(LB_MODE_3 & BLB0_MODE_2)
	---
	
	`avr.lock` also defines a macro that provides a default lockbit value:
	LOCKBITS_DEFAULT which is defined to be 0xFF.

	See the AVR device specific datasheet for more details about these
	lock bits and the available mode settings.
	
	A convenience enum, LOCKMEM, is defined as a GCC attribute for a 
	custom-named section of ".lock".
	
	A convenience template, LOCKBITS, is defined that declares a variable,
	__lock,  of type ubyte with the attribute defined by LOCKMEM. This variable
	allows the end user to easily set the lockbit data. Use mixin to define this
	variable with the appropriate linker section.

	Note: If a device-specific I/O header file has previously defined LOCKMEM,
	then LOCKMEM is not redefined. If a device-specific I/O header file has
	previously defined LOCKBITS, then LOCKBITS is not redefined. LOCKBITS is
	currently known to be defined in the I/O header files for the XMEGA devices.

	API_Usage_Example:
	
	Putting all of this together is easy:
	
	---
	import avr.io;

	mixin(LOCKBITS!`LB_MODE_1 & BLB0_MODE_3 & BLB1_MODE_4`);

	int main(void)
	{
			return 0;
	}
	---
	
	However there are a number of caveats that you need to be aware of to
	use this API properly.
	
	The .lock section in the ELF file will get its values from the initial 
	variable assignment ONLY. This means that you can NOT assign values to 
	this variable in functions and the new values will not be put into the
	ELF .lock section.
	
	The global variable is declared in the LOCKBITS macro has two leading 
	underscores, which means that it is reserved for the "implementation",
	meaning the library, so it will not conflict with a user-named variable.
	
	Be sure to have the -mmcu=<em>device</em> flag in your compile command line and
	your linker command line to have the correct device selected and to have 
	the correct I/O header file included when you import `avr.io`.

	You can print out the contents of the .lock section in the ELF file by
	using this command line:

	---
	avr-objdump -s -j .lock <ELF file>
	---
*/
module avr.lock;

/* Copyright (c) 2007, Atmel Corporation
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

   * Neither the name of the copyright holders nor the names of
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE. */

/* $Id: lock.h 2503 2016-02-07 22:59:47Z joerg_wunsch $ */

/* avr/lock.h - Lock Bits API */

version (LDC)
{
	public import ldc.attributes : section;

	enum LOCKBITS(string value) = `@(section(LOCKMEM)) ubyte __lock = ` ~ value ~ `;`;
}
else
	static assert(false, "Lockbits not implemented for this compiler");

enum LOCKBITS_DEFAULT = 0xFF;

static if (!is(typeof(LOCKMEM)))
	enum LOCKMEM = ".lock";

/* Lock Bit Modes */
static if (is(typeof(__LOCK_BITS_EXIST)))
{
	enum LB_MODE_1 = 0xFF;
	enum LB_MODE_2 = 0xFE;
	enum LB_MODE_3 = 0xFC;
}

static if (is(typeof(__BOOT_LOCK_BITS_0_EXIST)))
{
	enum BLB0_MODE_1 = 0xFF;
	enum BLB0_MODE_2 = 0xFB;
	enum BLB0_MODE_3 = 0xF3;
	enum BLB0_MODE_4 = 0xF7;
}

static if (is(typeof(__BOOT_LOCK_BITS_1_EXIST)))
{
	enum BLB1_MODE_1 = 0xFF;
	enum BLB1_MODE_2 = 0xEF;
	enum BLB1_MODE_3 = 0xCF;
	enum BLB1_MODE_4 = 0xDF;
}

static if (is(typeof(__BOOT_LOCK_APPLICATION_TABLE_BITS_EXIST)))
{
	enum BLBAT0 = ~_BV!2;
	enum BLBAT1 = ~_BV!3;
}

static if (is(typeof(__BOOT_LOCK_APPLICATION_BITS_EXIST)))
{
	enum BLBA0 = ~_BV!4;
	enum BLBA1 = ~_BV!5;
}

static if (is(typeof(__BOOT_LOCK_BOOT_BITS_EXIST)))
{
	enum BLBB0 = ~_BV!6;
	enum BLBB1 = ~_BV!7;
}
