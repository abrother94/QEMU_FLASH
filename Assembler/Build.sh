#/bin/sh
# ------------------------------------------------------------------
# To practice ARM connex board 
# Connex borad has 64M RAM
# refer to www.bravegnu.org/gnu-eprog/index.html
# ------------------------------------------------------------------

CCC=arm-linux-gnueabi-
pro=$1
rm $pro.o $pro.elf 

${CCC}as -gstabs -o $pro.o $pro.s
#arm-linux-ld -Ttext=0x34000000 -o $pro.elf $pro.o  
${CCC}ld -T sumarray.lds -o $pro.elf $pro.o  
${CCC}objcopy -O binary $pro.elf $pro.bin
dd if=/dev/zero of=flash.bin bs=256k count=256
dd if=$pro.bin of=flash.bin bs=256k conv=notrunc
#./qemu-system-arm -M versatilepb -m 256 -pflash flash.bin -nographic -S -s 
./qemu-system-arm-2.6.0-flash -M versatilepb -m 256 -pflash ./flash.bin -nographic  -serial /dev/null
 



