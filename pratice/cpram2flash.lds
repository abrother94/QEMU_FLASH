SECTIONS {
	. = 0x0
	.text : {
		* (.text);
	}
	flash_sdata = .;

	. = 0xa0000000;
	ram_sdata = .;
	.data : AT (flash_sdata) {
		* (.data);
	}
	ram_edata = .;
	datat_size = ram_edata - ram_sdata;
}
