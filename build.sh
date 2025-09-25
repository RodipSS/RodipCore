nasm bootloader.asm -f bin -o bootloader.bin 
gcc -ffreestanding -c kernel.c -o kernel.o 
ld -o kernel.bin -Ttext 0x10000 kernel.o --oformat binary 
cat bootloader.bin kernel.bin > RodipOS
qemu-system-x86_64 -hda RodipOS