void kmain(void) {
    volatile char *video = (volatile char*)0xB8000;

    video[0] = 'A';
    video[1] = 0x07;

    video[2] = 'B';
    video[3] = 0x07;

    video[4] = 'C';
    video[5] = 0x07;

    video[6] = 'D';
    video[7] = 0x07;

    video[8] = 'E';
    video[9] = 0x07;

    video[10] = 'F';
    video[11] = 0x07;

    video[12] = 'G';
    video[13] = 0x07;

    for (;;);
}
