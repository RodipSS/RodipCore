nasm main.asm -f bin -o main.bin
i686-elf-gcc -ffreestanding -m32 -c main.c -o mainc.o
i686-elf-ld -Ttext 0x0 --oformat binary mainc.o -o mainc.bin
copy /b main.bin + mainc.bin RodipOS.bin
qemu-system-x86_64 -fda RodipOS.bin