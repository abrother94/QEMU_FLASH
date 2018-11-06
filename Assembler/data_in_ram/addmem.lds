SECTIONS {
	. = 0x34000000;
	.text : { * (.text);}
	flash_sdata =.;

	. = 0x01000000;
	ram_sdata = .;
	.data : AT (flash_sdata) { 
		* (.data);
	}
	ram_edata = .;
	data_size = ram_edata - ram_sdata;
}
