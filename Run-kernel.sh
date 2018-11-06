#!/bin/sh

#ifconfig eth0 0.0.0.0
#ifconfig br0 192.168.1.148 netmask 255.255.255.0/24 up
#cp rootfs/etc/init.d/rcS-rootfs rootfs/etc/init.d/rcS
#./qemu-system-arm -kernel zImage -M versatilepb -m 128M -nographic -initrd testrootfs.img -append "console=ttyAMA0 root=/dev/ram rdinit=/test" 
 
cd rootfs/
./MKRFS.sh 
cd ../
./qemu-system-arm-2.6.0-flash -M versatilepb -kernel zImage  -nographic -initrd arm_root.img -append "console=ttyAMA0" 
#./qemu-system-arm-2.6.0-flash -M versatilepb -kernel zImage  -net nic -net tap -nographic -initrd arm_root.img -append "console=ttyAMA0" 

reset
#qemu-system-arm -kernel zImage -net nic -net tap -nographic -append "console=ttyAMA0 root=/dev/nfs rw nfsroot=10.8.0.56:/root/QEMU/testrootfs ip=10.8.0.249::10.8.0.56:255.255.255.0" 


#remote debug 
# ./qemu-system-arm-2.6.0-flash -M versatilepb  -m 256 -nographic -pflash ./flash.img -S -s
# arm-none-linux-gnueabi-gdb u-boot
