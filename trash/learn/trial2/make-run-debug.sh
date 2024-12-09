i386-elf-gcc -ffreestanding -m32 -g -c "kernel.cpp" -o "kernel.o" -fno-exceptions -fno-rtti
nasm "kernel_entry.asm" -f elf -o "kernel_entry.o"
i386-elf-ld -o "full_kernel.bin" -Ttext 0x1000 "kernel_entry.o" "kernel.o" --oformat binary
nasm "boot.asm" -f bin -o "boot.bin"

cat "boot.bin" "full_kernel.bin" > "bootloader.bin"
cat "bootloader.bin" "zeroes.bin" > "os.bin"

echo "i386-elf-gdb
target remote localhost:1234
symbol-file kernel.o
b main
(use c to continue, n for next, s for step, and p (variable) for print; to navigate through your code, inspect variables, and see how data is being manipulated)"

qemu-system-x86_64 -s -S -drive format=raw,file=os.bin
