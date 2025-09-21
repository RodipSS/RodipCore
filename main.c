void kmain() {
    volatile char *video = (volatile char*)0xB8000;
    video[0] = 'K';
    video[1] = 0x07;
    video[2] = '!';
    video[3] = 0x07;
    while(1);
}
