#!/bin/bash

#https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/


if [ "$1" == "C" ];then
    rm *.o ; rm nboot.map ; rm nboot.elf.srec ;rm nboot.bin ;rm nboot.elf; rm ../nboot.bin 
else

arm-linux-gnueabi-gcc  -D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8 -msoft-float  -D__KERNEL__ -DTEXT_BASE=0x01000000  -fno-builtin -ffreestanding -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.9/include -pipe  -DCONFIG_ARM -D__ARM__ -march=armv5te -mabi=apcs-gnu -mno-thumb-interwork -c -o start.o start.S

arm-linux-gnueabi-gcc -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8 -msoft-float  -D__KERNEL__ -DTEXT_BASE=0x01000000 -I/home/voltha/QEMU_FLASH/u-boot-armdev.git/include -fno-builtin -ffreestanding -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.9/include -pipe  -DCONFIG_ARM -D__ARM__ -march=armv5te -mabi=apcs-gnu -mno-thumb-interwork -Wall -Wstrict-prototypes -fno-stack-protector -c -o hello.o hello.c

arm-linux-gnueabi-ld -Bstatic -T boot.lds $UNDEF_SYM  -Ttext 0x01000000 hello.o  start.o -o nboot.elf -Map nboot.map

arm-linux-gnueabi-objcopy -O srec nboot.elf nboot.elf.srec

arm-linux-gnueabi-objcopy --gap-fill=0xff -O binary nboot.elf nboot.bin

 
cp nboot.bin ../
fi
