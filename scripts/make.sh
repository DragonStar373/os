i386-elf-gcc -ffreestanding -m32 -g -c "cpp_main.cpp" -o "cpp_main.o" -fno-exceptions -fno-rtti
echo "cpp_main.cpp compiled"

nasm "entry.asm" -f elf -o "entry.o"
echo "entry.asm assembled"

nasm "asm_entry_main.asm" -f elf -o "asm_entry_main.o"
echo "asm_entry_main.asm assembled"

nasm "char.asm" -f elf -o "char.o"
echo "char.asm assembled"

i386-elf-ld -o "entry.bin" -Ttext 0x1000 "entry.o" "cpp_main.o" "asm_entry_main.o" "char.o" --oformat binary
echo "linked"

nasm "boot1.asm" -f bin -o "boot1.bin"
echo "bootloader stage 1 assembled & compiled"

nasm "boot2.asm" -f bin -o "boot2.bin"
echo "bootloader stage 2 assembled & compiled"

nasm "zeroes.asm" -f bin -o "zeroes.bin"
echo "zeroes assembled & compiled"

cat "boot1.bin" "boot2.bin" > "boot.bin"
cat "boot.bin" "entry.bin" > "entrystub.bin"
cat "entrystub.bin" "zeroes.bin" > "os.bin"
echo "finished, cleaning up;"
mv cpp_main.o ./build/cpp_main.o
mv entry.o ./build/entry.o
mv entry.bin ./build/entry.bin
mv boot1.bin ./build/boot1.bin
mv boot2.bin ./build/boot2.bin
mv boot.bin ./build/boot.bin
mv entrystub.bin ./build/entrystub.bin
mv zeroes.bin ./build/zeroes.bin
mv asm_entry_main.o ./build/asm_entry_main.o
echo "cleaned"
