#!/usr/bin/env rdmd

import std.algorithm;
import std.array;
import std.ascii;
import std.file;
import std.range;
import std.stdio;
import std.string;

enum InterestingSection
{
	_other,
	asm_arch,
	cpp
}

enum Architecture
{
	none,
	avr1,
	avr2,
	avr25,
	avr3,
	avr31,
	avr35,
	avr4,
	avr5,
	avr51,
	avr6,
	avrtiny,
	avrxmega2,
	avrxmega3,
	avrxmega4,
	avrxmega5,
	avrxmega6,
	avrxmega7,
}

// https://www.microchip.com/webdoc/AVRLibcReferenceManual/using_tools_1using_avr_gcc_mach_opt.html
// https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-arch.h#L57
// https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c#L46
// https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-c.c#L293
//dfmt off
static immutable string[Architecture.max + 1] architectureCode =
[
	null, // none
	// avr1
	q{
enum __AVR_ARCH__ = 1;
enum __AVR_ASM_ONLY__ = true;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = false;
enum __AVR_MEGA__ = false;
enum __AVR_HAVE_LPMX__ = false;
enum __AVR_HAVE_MOVW__ = false;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr2
	q{
enum __AVR_ARCH__ = 2;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = false;
enum __AVR_MEGA__ = false;
enum __AVR_HAVE_LPMX__ = false;
enum __AVR_HAVE_MOVW__ = false;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr25
	q{
enum __AVR_ARCH__ = 25;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = false;
enum __AVR_MEGA__ = false;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr3
	q{
enum __AVR_ARCH__ = 3;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = false;
enum __AVR_HAVE_MOVW__ = false;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr31
	q{
enum __AVR_ARCH__ = 31;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = false;
enum __AVR_HAVE_MOVW__ = false;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr35
	q{
enum __AVR_ARCH__ = 35;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr4
	q{
enum __AVR_ARCH__ = 4;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = false;
enum __AVR_MEGA__ = false;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr5
	q{
enum __AVR_ARCH__ = 5;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr51
	q{
enum __AVR_ARCH__ = 51;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avr6
	q{
enum __AVR_ARCH__ = 6;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = true;
enum __AVR_2_BYTE_PC__ = false;
enum __AVR_3_BYTE_PC__ = true;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 32;
},
	// avrtiny
	q{
enum __AVR_ARCH__ = 100;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = false;
enum __AVR_HAVE_MUL__ = false;
enum __AVR_HAVE_JMP_CALL__ = false;
enum __AVR_MEGA__ = false;
enum __AVR_HAVE_LPMX__ = false;
enum __AVR_HAVE_MOVW__ = false;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = false;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = true;
enum __AVR_PM_BASE_ADDRESS__ = 0x4000;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega2
	q{
enum __AVR_ARCH__ = 102;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega3
	q{
enum __AVR_ARCH__ = 103;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = false;
enum __AVR_HAVE_ELPMX__ = false;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0x8000;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega4
	q{
enum __AVR_ARCH__ = 104;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega5
	q{
enum __AVR_ARCH__ = 105;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = false;
enum __AVR_2_BYTE_PC__ = true;
enum __AVR_3_BYTE_PC__ = false;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = true;
enum __AVR_HAVE_RAMPY__ = true;
enum __AVR_HAVE_RAMPZ__ = true;
enum __AVR_HAVE_RAMPD__ = true;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega6
	q{
enum __AVR_ARCH__ = 106;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = true;
enum __AVR_2_BYTE_PC__ = false;
enum __AVR_3_BYTE_PC__ = true;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = false;
enum __AVR_HAVE_RAMPY__ = false;
enum __AVR_HAVE_RAMPZ__ = false;
enum __AVR_HAVE_RAMPD__ = false;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 0;
},
	// avrxmega7
	q{
enum __AVR_ARCH__ = 107;
enum __AVR_ASM_ONLY__ = false;
enum __AVR_ENHANCED__ = true;
enum __AVR_HAVE_MUL__ = true;
enum __AVR_HAVE_JMP_CALL__ = true;
enum __AVR_MEGA__ = true;
enum __AVR_HAVE_LPMX__ = true;
enum __AVR_HAVE_MOVW__ = true;
enum __AVR_HAVE_ELPM__ = true;
enum __AVR_HAVE_ELPMX__ = true;
enum __AVR_HAVE_EIJMP_EICALL_ = true;
enum __AVR_2_BYTE_PC__ = false;
enum __AVR_3_BYTE_PC__ = true;
enum __AVR_XMEGA__ = true;
enum __AVR_HAVE_RAMPX__ = true;
enum __AVR_HAVE_RAMPY__ = true;
enum __AVR_HAVE_RAMPZ__ = true;
enum __AVR_HAVE_RAMPD__ = true;
enum __AVR_TINY__ = false;
enum __AVR_PM_BASE_ADDRESS__ = 0;
enum __AVR_SFR_OFFSET__ = 0;
},
];
//dfmt on

struct Info
{
	Architecture architecture;
	string defines;
	string[] versions;
	string name;
}

Info parseFile(string file)
{
	InterestingSection section;

	Info info;

	Lines: foreach (line; File(file).byLine)
	{
		line = line.strip;
		if (!line.length || line[0] == '#')
			continue;

		if (line[0] == '*' && line[$ - 1] == ':')
		{
			auto sectionName = line[1 .. $ - 1];
			section = InterestingSection._other;
			static foreach (avail; __traits(allMembers, InterestingSection)[1 .. $])
			{
				if (sectionName == avail)
				{
					section = __traits(getMember, InterestingSection, avail);
					continue Lines;
				}
			}
		}
		else
		{
			switch (section)
			{
			case InterestingSection.asm_arch:
				processAsmArchLine(info, line);
				break;
			case InterestingSection.cpp:
				processCppLine(info, line);
				break;
			default:
				break;
			}
		}
	}

	return info;
}

void processAsmArchLine(ref Info info, const(char)[] line)
{
	if (line.startsWith("-mmcu="))
	{
		line = line["-mmcu=".length .. $].strip;
	ArchSwitch:
		switch (line)
		{
			static foreach (arch; __traits(allMembers, Architecture)[1 .. $])
			{
		case arch:
				info.architecture = __traits(getMember, Architecture, arch);
				break ArchSwitch;
			}
		default:
			writeln("Unknown architecture ", line);
			break;
		}
	}
}

void processCppLine(ref Info info, const(char)[] line)
{
	while (line.length)
	{
		auto end = line.indexOf(' ');
		if (end == -1)
			end = line.length;

		auto part = line[0 .. end];
		line = line[end .. $].stripLeft;

		if (part.startsWith("-D"))
		{
			part = part[2 .. $];
			auto eq = part.indexOf('=');
			if (eq == -1)
				info.versions ~= part.idup;
			else
			{
				auto vstr = part[eq + 1 .. $];
				string value;
				if (vstr.all!isDigit)
					value = vstr.idup;
				else
					value = '"' ~ vstr.idup ~ '"';
				info.defines ~= "enum " ~ part[0 .. eq].idup ~ " = " ~ value ~ ";\n";

				if (part[0 .. eq] == "__AVR_DEVICE_NAME__")
					info.name = vstr.idup;
			}
		}
		else
			stderr.writeln("Unparsable cpp flag starting at ", part, " ", line);
	}
}

void main(string[] args)
{
	string[] names;

	auto dub_sdl = File("dub.sdl", "w");
	{
		auto dub_sdl_prefix = File("dub.sdl.pre", "r");
		foreach (chunk; dub_sdl_prefix.byChunk(4096))
			dub_sdl.rawWrite(chunk);
	}

	string[string] iomaps;
	foreach (map; File("iomaps.txt").byLineCopy)
	{
		auto parts = map.findSplit("\t");
		iomaps[parts[0]] = parts[2];
	}

	auto files = dirEntries("device-specs", SpanMode.shallow).array;
	foreach (spec; files.sort!"a<b")
	{
		if (!spec.isFile)
			continue;

		auto info = parseFile(spec);
		if (!info.name.length)
		{
			stderr.writeln(spec, ": error: no device name");
			continue;
		}
		if (info.architecture == Architecture.none)
			stderr.writeln(spec, ": warning: no architecture found");

		names ~= info.name;

		auto output = File("src-devices/avr/specs/specs_" ~ info.name ~ ".d", "w");
		output.writeln("/**");
		output.writeln(" *");
		output.writeln(" * THIS FILE IS AUTO-GENERATED BY " ~ __FILE__ ~ " FOR MCU ",
				info.name, " WITH ARCHITECTURE ", info.architecture);
		output.writeln(" *");
		output.writeln(" */");
		output.writeln("");
		output.writeln("module avr.specs.specs_" ~ info.name ~ ";");
		output.writeln();
		output.writeln(architectureCode[info.architecture]);
		output.writeln(info.defines);

		string iomap;
		foreach (ver; info.versions)
			if (auto m = ver in iomaps)
				iomap = *m;

		foreach (mod; [null, "-obj", "-asm"])
		{
			dub_sdl.writeln(`configuration "` ~ info.name ~ mod ~ `" {`);
			if (info.versions.length)
				dub_sdl.writefln(`	versions %(%s" "%)`, info.versions);
			dub_sdl.writeln(
					`	sourceFiles "src-devices/avr/device/` ~ iomap
					~ `.d" "src-devices/avr/specs/specs_` ~ info.name ~ `.d"`);
			dub_sdl.writeln(`	lflags "--gc-sections"`);
			if (mod == "-obj")
			{
				dub_sdl.writeln(
						`	dflags "-mtriple=avr" "-mcpu=` ~ info.name ~ `" "-output-o" platform="ldc"`);
				dub_sdl.writeln(`	postBuildCommands "avr-gcc -mmcu=` ~ info.name
						~ ` -Wall -Wl,\"$${LFLAGS// /,}\" $$DUB_TARGET_PATH/obj/*.o -o \"$$DUB_TARGET_NAME.elf\"" `
						~ `"avr-objcopy -O ihex -R .eeprom -R .fuse \"$$DUB_TARGET_NAME.elf\" \"$$DUB_TARGET_NAME.hex\""`);
			}
			else if (mod == "-asm")
			{
				dub_sdl.writeln(
						`	dflags "-mtriple=avr" "-mcpu=` ~ info.name ~ `" "-output-s" platform="ldc"`);
				dub_sdl.writeln(
						`	postBuildCommands "echo \"Not linking files because they have been generated as assembly files\""`);
			}
			else
			{
				dub_sdl.writeln(
						`	dflags "-mtriple=avr" "-mcpu=` ~ info.name ~ `" "-output-ll" platform="ldc"`);
				dub_sdl.writeln(`	postBuildCommands "llvm-link -S -o .dub/$$DUB_TARGET_NAME.ll $$DUB_TARGET_PATH/obj/*.ll" `
						~ `"opt -S -Oz --inline --strip-dead-prototypes --strip-dead-debug-info --strip`
						~ ` .dub/$$DUB_TARGET_NAME.ll --march=avr --mcpu=` ~ info.name ~ ` -o .dub/$$DUB_TARGET_NAME.opt.ll" `
						~ `"llc .dub/$$DUB_TARGET_NAME.opt.ll --march=avr --mcpu=` ~ info.name
						~ ` -filetype=obj -O2 -o .dub/$$DUB_TARGET_NAME.o" "avr-gcc -mmcu=` ~ info.name
						~ ` -Wall -Wl,\"$${LFLAGS// /,}\" .dub/$$DUB_TARGET_NAME.o -o \"$$DUB_TARGET_NAME.elf\"" `
						~ `"avr-objcopy -O ihex -R .eeprom -R .fuse \"$$DUB_TARGET_NAME.elf\" \"$$DUB_TARGET_NAME.hex\""`);
			}
			dub_sdl.writeln(`}`);
		}
	}
}
