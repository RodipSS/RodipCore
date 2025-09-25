void kmain(void){
    volatile char *video = (volatile char*)0xB8000;

    
    video[0] = ('@' | 0x07 << 8);
    video[1] = ('H' | 0x07 << 8);
    video[2] = ('@' | 0x07 << 8);
    video[3] = ('E' | 0x07 << 8);
    video[4] = ('@' | 0x07 << 8);
    video[5] = ('L' | 0x07 << 8);
    video[6] = ('@' | 0x07 << 8);
    video[7] = ('L' | 0x07 << 8);
    video[8] = ('@' | 0x07 << 8);
    video[9] = ('O' | 0x07 << 8);
    video[10] = ('@' | 0x07 << 8);
    video[11] = (' ' | 0x07 << 8);
    video[12] = ('@' | 0x07 << 8);
    video[13] = ('W' | 0x07 << 8);
    video[14] = ('@' | 0x07 << 8);
    video[15] = ('O' | 0x07 << 8);
    video[16] = ('@' | 0x07 << 8);
    video[17] = ('R' | 0x07 << 8);
    video[18] = ('@' | 0x07 << 8);
    video[19] = ('L' | 0x07 << 8);
    video[20] = ('@' | 0x07 << 8);
    video[21] = ('D' | 0x07 << 8);
    video[22] = ('@' | 0x07 << 8);
    video[23] = ('!' | 0x07 << 8);

    for(;;);
}