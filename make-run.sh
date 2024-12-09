i386-elf-gcc -ffreestanding -m32 -g -c "kernel.cpp" -o "kernel.o" -fno-exceptions -fno-rtti
echo "kernel.cpp compiled"
nasm "kernel_entry.asm" -f elf -o "kernel_entry.o"
echo "kernel_entry.asm assembled"
nasm "kernel_asm_main.asm" -f elf -o "kernel_asm_main.o"
echo "kernel_asm_main.asm assembled"
i386-elf-ld -o "full_kernel.bin" -Ttext 0x1000 "kernel_entry.o" "kernel.o" "kernel_asm_main.o" --oformat binary
echo "linked"
nasm "boot.asm" -f bin -o "boot.bin"
echo "bootloader assembled & compiled"
nasm "zeroes.asm" -f bin -o "zeroes.bin"
echo "zeroes assembled & compiled"
cat "boot.bin" "full_kernel.bin" > "bootloader.bin"
cat "bootloader.bin" "zeroes.bin" > "os.bin"
echo "finished, cleaning up;"
mv kernel.o ./build/kernel.o
mv kernel_entry.o ./build/kernel_entry.o
mv full_kernel.bin ./build/fullkernel.bin
mv boot.bin ./build/boot.bin
mv bootloader.bin ./build/bootloader.bin
mv zeroes.bin ./build/zeroes.bin
mv kernel_asm_main.o ./build/kernel_asm_main.o
echo "cleaned, running qemu;"
qemu-system-x86_64 os.bin
