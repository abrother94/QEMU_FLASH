#!/bin/sh
ifconfig eth7 0.0.0.0
ifconfig br0 192.168.2.108 netmask 255.255.255.0
cp rootfs/etc/init.d/rcS-rootfs rootfs/etc/init.d/rcS
#./qemu-system-arm -kernel zImage -M versatilepb -m 128M -nographic -initrd testrootfs.img -append "console=ttyAMA0 root=/dev/ram rdinit=/test" 
./qemu-system-arm -M versatilepb -kernel zImage  -nographic -initrd arm_root1.img -append "console=ttyAMA0" 
#qemu-system-arm -kernel zImage -net nic -net tap -nographic -append "console=ttyAMA0 root=/dev/nfs rw nfsroot=10.8.0.56:/root/QEMU/testrootfs ip=10.8.0.249::10.8.0.56:255.255.255.0" 


