module avr.util.delay;

// version = AvrLibcDelay;

/* Copyright (c) 2002, Marek Michalkiewicz
   Copyright (c) 2007 Joerg Wunsch
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

/* $Id: delay_basic.h 2453 2014-10-19 08:18:11Z saaadhu $ */

/* Ported and adapted to D */

import ldc.attributes;

struct BasicDelay
{
pragma(inline, true) @section(".progmem.data.inlines_basicdelay") :

	/** 
		Delay loop using an 8-bit counter `count`, so up to 256
		iterations are possible.  (The value 256 would have to be passed
		as 0.)  The loop executes three CPU cycles per iteration, not
		including the overhead the compiler needs to setup the counter
		register.

		Thus, at a CPU speed of 1 MHz, delays of up to 768 microseconds
		can be achieved.
	*/
	static void loop8(ubyte count)
	{
		import ldc.llvmasm : __asm;

		cast(void) __asm!ubyte(`
			1: dec $0
			brne 1b
		`, "=r,0", count);
	}

	/**
		Delay loop using a 16-bit counter `count`, so up to 65536
		iterations are possible.  (The value 65536 would have to be
		passed as 0.)  The loop executes four CPU cycles per iteration,
		not including the overhead the compiler requires to setup the
		counter register pair.

		Thus, at a CPU speed of 1 MHz, delays of up to about 262.1
		milliseconds can be achieved.
	*/
	static void loop16(ushort count)
	{
		import ldc.llvmasm : __asm;

		cast(void) __asm!ushort(`
			1: sbiw $0,1
			brne 1b
		`, "=w,0", count);
	}
}

enum KHz = 1000;
enum MHz = 1000 * KHz;

version (AvrLibcDelay)
{
	extern (C) void __builtin_avr_delay_cycles(uint);
}

struct FrequencyDelay(int frequency)
{
pragma(inline, true) @section(".progmem.data.inlines_delay_" ~ frequency.stringof) :
	static void delayUsecs(double us)()
	{
		version (AvrLibcDelay)
		{
			enum ticks = cast(uint)(frequency / 1.0e6 * us);
			__builtin_avr_delay_cycles(ticks);
		}
		else
		{
			enum tmp1 = (frequency / 3.0e6) * us;
			enum tmp2 = (frequency / 4.0e6) * us;

			static if (tmp1 < 1)
				BasicDelay.loop8(1);
			else static if (tmp2 > 65535)
				delayMsecs!(us / 1000.0)();
			else static if (tmp1 > 255)
				BasicDelay.loop16(cast(ushort) tmp2);
			else
				BasicDelay.loop8(cast(ubyte) tmp1);
		}
	}

	static void delayMsecs(double ms)()
	{
		version (AvrLibcDelay)
		{
			enum ticks = cast(uint)(frequency / 1.0e3 * ms);
			__builtin_avr_delay_cycles(ticks);
		}
		else
		{
			enum tmp = (frequency / 4.0e3) * ms;
			static if (tmp < 1.0)
				BasicDelay.loop8(1);
			else static if (tmp > 65535)
			{
				ushort ticks = cast(ushort) ms * 10;
				enum tens = (frequency / 4.0e3) / 10;
				while (ticks)
				{
					BasicDelay.loop16(cast(ushort) tens);
					ticks--;
				}
			}
			else
				BasicDelay.loop16(cast(ushort) tmp);
		}
	}
}
