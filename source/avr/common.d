module avr.common;

import avr.io;

static if (__AVR_ARCH__ >= 100)
{
	static if (!is(typeof(SPL)))
		enum SPL = _SFR_MEM8!0x3D;

	static if (!is(typeof(SPH)))
		enum SPH = _SFR_MEM8!0x3E;

	static if (!is(typeof(SP)))
		enum SP = _SFR_MEM16!0x3D;
}
else static if (__AVR_ARCH__ != 1)
{
	static if (!is(typeof(SPL)))
		enum SPL = _SFR_IO8!0x3D;

	static if (XRAMEND < 0x100)
	{
		static if (!is(typeof(SP)))
			enum SP = _SFR_IO8!0x3D;
	}
	else
	{
		static if (!is(typeof(SP)))
			enum SP = _SFR_IO16!0x3D;

		static if (!is(typeof(SPH)))
			enum SPH = _SFR_IO8!0x3E;
	}
}

static if (!is(typeof(SREG)))
{
	static if (__AVR_ARCH__ >= 100)
		enum SREG = _SFR_MEM8!0x3F;
	else
		enum SREG = _SFR_IO8!0x3F;
}

static foreach (i, b; "CZNVSHTI")
{
	static if (!is(typeof(mixin("SREG_" ~ b))))
		mixin("enum SREG_" ~ b ~ " = " ~ i.stringof ~ ";");
}

/*------------ Common Symbols ------------*/

/* 
Generic definitions for registers that are common across multiple AVR devices
and families.
*/

/* Pointer registers definitions */

/* avr1 does not have X and Y pointers */
// TODO: registers here
// static if (__AVR_ARCH__ != 1)
// {
// 	alias XL = r26;
// 	alias XH = r27;
// 	alias YL = r28;
// 	alias YH = r29;
// }
// alias ZL = r30;
// alias ZH = r31;

/* Status Register */
static if (is(typeof(SREG)))
{
	enum AVR_STATUS_REG = SREG;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_STATUS_ADDR = _SFR_MEM_ADDR!SREG;
	else
		enum AVR_STATUS_ADDR = _SFR_IO_ADDR!SREG;
}

/* Stack Pointer (combined) Register */
static if (is(typeof(SP)))
{
	enum AVR_STACK_POINTER_REG = SP;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_STACK_POINTER_ADDR = _SFR_MEM_ADDR!SP;
	else
		enum AVR_STACK_POINTER_ADDR = _SFR_IO_ADDR!SP;
}

/* Stack Pointer High Register */
static if (is(typeof(SPH)))
{
	enum _HAVE_AVR_STACK_POINTER_HI = 1;
	enum AVR_STACK_POINTER_HI_REG = SPH;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_STACK_POINTER_HI_ADDR = _SFR_MEM_ADDR!SPH;
	else
		enum AVR_STACK_POINTER_HI_ADDR = _SFR_IO_ADDR!SPH;
}

/* Stack Pointer Low Register */
static if (is(typeof(SPL)))
{
	enum AVR_STACK_POINTER_LO_REG = SPL;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_STACK_POINTER_LO_ADDR = _SFR_MEM_ADDR!SPL;
	else
		enum AVR_STACK_POINTER_LO_ADDR = _SFR_IO_ADDR!SPL;
}

/* RAMPD Register */
static if (is(typeof(RAMPD)))
{
	enum AVR_RAMPD_REG = RAMPD;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_RAMPD_ADDR = _SFR_MEM_ADDR!RAMPD;
	else
		enum AVR_RAMPD_ADDR = _SFR_IO_ADDR!RAMPD;
}

/* RAMPX Register */
static if (is(typeof(RAMPX)))
{
	enum AVR_RAMPX_REG = RAMPX;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_RAMPX_ADDR = _SFR_MEM_ADDR!RAMPX;
	else
		enum AVR_RAMPX_ADDR = _SFR_IO_ADDR!RAMPX;
}

/* RAMPY Register */
static if (is(typeof(RAMPY)))
{
	enum AVR_RAMPY_REG = RAMPY;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_RAMPY_ADDR = _SFR_MEM_ADDR!RAMPY;
	else
		enum AVR_RAMPY_ADDR = _SFR_IO_ADDR!RAMPY;
}

/* RAMPZ Register */
static if (is(typeof(RAMPZ)))
{
	enum AVR_RAMPZ_REG = RAMPZ;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_RAMPZ_ADDR = _SFR_MEM_ADDR!RAMPZ;
	else
		enum AVR_RAMPZ_ADDR = _SFR_IO_ADDR!RAMPZ;
}

/* Extended Indirect Register */
static if (is(typeof(EIND)))
{
	enum AVR_EXTENDED_INDIRECT_REG = EIND;
	static if (__AVR_ARCH__ >= 100)
		enum AVR_EXTENDED_INDIRECT_ADDR = _SFR_MEM_ADDR!EIND;
	else
		enum AVR_EXTENDED_INDIRECT_ADDR = _SFR_IO_ADDR!EIND;
}
