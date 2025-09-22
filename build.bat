nasm main.asm -f bin -o main.bin
i686-elf-gcc -ffreestanding -m32 -nostdlib -nostartfiles -c main.c -o mainc.o
i686-elf-ld -T linker.ld --oformat binary mainc.o -o mainc.bin
copy /b main.bin + mainc.bin RodipOS.bin
qemu-system-i386 -hda RodipOS.bin