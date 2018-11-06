#/bin/sh
./qemu-system-arm-2.6.0-flash -kernel u-boot.bin -initrd arm_root.img -M versatilepb -nographic -append console=ttyAMA0 
reset
