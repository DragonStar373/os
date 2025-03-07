bash ./scripts/make.sh
echo "Running qemu, sending serial output to console"
qemu-system-x86_64 -serial stdio os.bin
