#/bin/sh
# ------------------------------------------------------------------
# To practice ARM connex board 
# Connex borad has 64M RAM
# refer to www.bravegnu.org/gnu-eprog/index.html
# ------------------------------------------------------------------


pro=$1

dbg=$2

rm $pro.o $pro.elf 

arm-linux-as -gstabs -o $pro.o $pro.s
#arm-linux-ld -Ttext=0x34000000 -o $pro.elf $pro.o  
arm-linux-ld -T $pro.lds -o $pro.elf $pro.o  
arm-linux-objcopy -O binary $pro.elf $pro.bin
dd if=/dev/zero of=flash.bin bs=256k count=256
dd if=$pro.bin of=flash.bin bs=256k conv=notrunc

if [ "$dbg" == "d" ];then
	./qemu-system-arm -M versatilepb -m 256 -pflash flash.bin -nographic -S -s 

else
	./qemu-system-arm -M versatilepb -m 256 -pflash ./flash.bin -nographic -serial /dev/null
fi


