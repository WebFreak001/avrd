module avr.portpins;

/* Copyright (c) 2003  Theodore A. Roth
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

/* $Id: portpins.h 1936 2009-03-19 22:19:26Z arcanum $ */

/* Define Generic PORTn, DDn, and PINn values. */

/* Port Data Register (generic) */
enum PORT7 = 7;
enum PORT6 = 6;
enum PORT5 = 5;
enum PORT4 = 4;
enum PORT3 = 3;
enum PORT2 = 2;
enum PORT1 = 1;
enum PORT0 = 0;

/* Port Data Direction Register (generic) */
enum DD7 = 7;
enum DD6 = 6;
enum DD5 = 5;
enum DD4 = 4;
enum DD3 = 3;
enum DD2 = 2;
enum DD1 = 1;
enum DD0 = 0;

/* Port Input Pins (generic) */
enum PIN7 = 7;
enum PIN6 = 6;
enum PIN5 = 5;
enum PIN4 = 4;
enum PIN3 = 3;
enum PIN2 = 2;
enum PIN1 = 1;
enum PIN0 = 0;

/* Define PORTxn an Pxn values for all possible port pins if not defined already by io.h. */
static foreach (x; "ABCDEFGHIJKL")
{
	static foreach (n; 0 .. 8)
	{
		static if (is(typeof(mixin("P" ~ x ~ n.stringof))) && !is(typeof(mixin("PORT" ~ x ~ n.stringof))))
		{
			mixin("alias PORT" ~ x ~ n.stringof ~ " = P" ~ x ~ n.stringof ~ ";");
		}
		else static if (is(typeof(mixin("PORT" ~ x ~ n.stringof)))
				&& !is(typeof(mixin("P" ~ x ~ n.stringof))))
		{
			mixin("alias P" ~ x ~ n.stringof ~ " = PORT" ~ x ~ n.stringof ~ ";");
		}
	}
}
