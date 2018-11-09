rm arm_root.img
rm kernel/linux-4.2.1.tar.gz
rm -rf   kernel/linux-4.2.1/
rm qemu-system-arm-2.6.0-flash
rm qemu/qemu-2.6.0.tar.xz
rm -rf  qemu/qemu-2.6.0/
rm -rf   rootfs/
rm u-boot
rm u-boot.bin
rm uImage
rm zImage
cd busybox
make clean

cd ../
