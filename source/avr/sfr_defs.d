module avr.sfr_defs;

/* Copyright (c) 2002, Marek Michalkiewicz <marekm@amelek.gda.pl>
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
   POSSIBILITY OF SUCH DAMAGE.  */

/* avr/sfr_defs.h - macros for accessing AVR special function registers */

/* $Id: sfr_defs.h 1691 2008-04-28 22:05:42Z arcanum $ */

/* Manually translated to D */

public import avr.specs;

import core.bitop;
import ldc.attributes;

/// Helper struct to automatically call volatileStore and volatileLoad on assignment/reading of pointers
struct VolatileRef(T, alias addr)
{
	alias get this;

pragma(inline, true) @section(".progmem.data.inlines_volatileref_" ~ addr.stringof) :

	// TODO: the following functions still make it into the resulting HEX file, even though they are unused if always inlined
	// they should be removed from the hex file somehow, but they don't get stripped or removed by -Wl,--gc-sections

	T* ptr()()
	{
		return cast(T*)(addr);
	}

	T get()()
	{
		return volatileLoad(ptr);
	}

	void opAssign()(T value)
	{
		volatileStore(ptr, value);
	}

	auto opOpAssign(string op)(T value)
	{
		T ret;
		mixin("volatileStore(ptr, ret = cast(T)(volatileLoad(ptr) " ~ op ~ " value));");
		return ret;
	}
}

enum _MMIO_BYTE(alias io_addr) = VolatileRef!(ubyte, cast(ubyte*) io_addr)();
enum _MMIO_WORD(alias io_addr) = VolatileRef!(ushort, cast(ushort*) io_addr)();
enum _MMIO_DWORD(alias io_addr) = VolatileRef!(uint, cast(uint*) io_addr)();

// no asm compat

enum __SFR_OFFSET = __AVR_SFR_OFFSET__;

enum _SFR_MEM8(alias mem_addr) = _MMIO_BYTE!(mem_addr);
enum _SFR_MEM16(alias mem_addr) = _MMIO_WORD!(mem_addr);
enum _SFR_MEM32(alias mem_addr) = _MMIO_DWORD!(mem_addr);
enum _SFR_IO8(alias io_addr) = _MMIO_BYTE!(__SFR_OFFSET + io_addr);
enum _SFR_IO16(alias io_addr) = _MMIO_WORD!(__SFR_OFFSET + io_addr);

template _SFR_MEM_ADDR(alias sfr)
{
	static if (is(typeof(sfr) : VolatileRef!(T, v), T, alias v))
		enum _SFR_MEM_ADDR = cast(ushort) v;
	else
		static assert(false, "Can only take _SFR_MEM_ADDR of VolatileRef struct");
}

enum _SFR_IO_ADDR(alias sfr) = _SFR_MEM_ADDR!(sfr) - __SFR_OFFSET;
enum _SFR_IO_REG_P(alias sfr) = _SFR_MEM_ADDR!(sfr) < 0x40 + __SFR_OFFSET;

alias _SFR_ADDR = _SFR_MEM_ADDR;

enum _SFR_BYTE(alias sfr) = _MMIO_BYTE!(_SFR_ADDR!(sfr));
enum _SFR_WORD(alias sfr) = _MMIO_WORD!(_SFR_ADDR!(sfr));
enum _SFR_DWORD(alias sfr) = _MMIO_DWORD!(_SFR_ADDR!(sfr));

enum _BV(int bit) = 1 << bit;

pragma(inline, true) bool bit_is_set(alias sfr, int bit)()
{
	return _SFR_BYTE!sfr & _BV!bit;
}

pragma(inline, true) bool bit_is_clear(alias sfr, int bit)()
{
	return !(_SFR_BYTE!sfr & _BV!bit);
}

pragma(inline, true) void loop_until_bit_is_set(alias sfr, int bit)()
{
	do
	{
	}
	while (bit_is_clear(sfr, bit));
}

pragma(inline, true) void loop_until_bit_is_clear(alias sfr, int bit)()
{
	do
	{
	}
	while (bit_is_set(sfr, bit));
}
