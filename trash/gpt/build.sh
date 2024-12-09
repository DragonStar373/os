#!/bin/bash

NASM="nasm"
LILO="lilo"
MFORMAT="mformat"

if [ ! -f bootloader.bin ]; then
    echo "Assembling bootloader..."
    $NASM --verbose -f bin bootloader.asm > /dev/null
    mv bootloader.o bootloader.bin
fi

echo "Building ISO image..."
dd if=/dev/zero of=boot.iso bs=512 count=1
dd if=/dev/sda conv=sync,noerror bs=512 count=1 of=boot.iso >> /dev/null 
2>&1
mkdir iso
mount -o loop boot.iso iso/
cp bootloader.bin iso/mbr/
echo "Creating ISO file system..."
mkdir iso/boot
echo "String data" > iso/boot/data.txt
echo "Hello World!" >> iso/boot/data.txt
mkdir iso/EFI
touch iso/EFI/BOOT.cfg
umount iso
$MFORMAT -r boot.iso 4096
