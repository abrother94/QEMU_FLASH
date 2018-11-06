OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(start)
SECTIONS {
	. = 0x0;
	.text : { * (.text);}

	. = 0x80000000;
	.data : { * (.data);}
}
