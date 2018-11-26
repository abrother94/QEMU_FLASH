#!/bin/sh
# -e : erase block 0x20000 = 128k, -d : from rootfs -o : output image name
#mkfs.jffs2 -e 0x20000 -d initramfs/ -o arm_rootjffs2.img
dd if=/dev/zero of=./flash.img bs=256k count=256
dd if=nboot.bin of=./flash.img bs=256k conv=notrunc
# gdb remote debug
#./qemu-system-arm -M versatilepb -m 256  -nographic -pflash ./flash.img -s -S
#./qemu-system-arm-2.6.0-flash -M versatilepb  -m 256 -nographic -pflash ./flash.img -s -S
./qemu-system-arm-2.6.0-flash -M versatilepb  -m 256 -nographic -pflash ./flash.img 
reset
#./qemu-system-arm -kernel zImage -M versatilepb -m 128M -nographic -initrd testrootfs.img -append "console=ttyAMA0 root=/dev/ram rdinit=/test" 
#./qemu-system-arm -M versatilepb -m 200  -net nic -net tap -nographic -pflash ./flash.img
