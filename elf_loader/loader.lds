/* Copyright 2017-2018  Dexter Gerig <dexgerig@gmail.com>
   Copyright 2008-2009  Segher Boessenkool  <segher@kernel.crashing.org>
   This code is licensed to you under the terms of the GNU GPL, version 2;
   see file COPYING or http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt  */

OUTPUT_FORMAT("elf32-powerpc")
OUTPUT_ARCH(powerpc:common)

ENTRY(_start)

SECTIONS {
	/* Use apploader memory so that we don't clash with out "parent" app */
	. = 0x81330000;

	.start : { crt0.o(*) }
	.text : { *(.text) }
	.rodata : { *(.rodata .rodata.*)}
	.data : { *(.data) }

	__bss_start = .;
	.bss : { *(.bss) }
	__bss_end = .;

	. = ALIGN(0x40);
	.stack : {
		. += 0x8000;
		_stack_top = .;
	}
}
