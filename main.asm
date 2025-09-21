[org 0x7c00]
mov si, msg
listen:
    lodsb
    mov ah, 0x0e
    int 0x10
    cmp al, 0
    je end
    jmp listen
print_String:
    msg db "Hello World! (from bootloader btw)", 0Ah, 0Dh, 0
end:
    jmp $
xor ax, ax
mov si, 0
mov ah, 0x02
mov al, 4
mov ch, 0
mov cl, 2
mov dl, 0x0e
times 510-($-$$) db 0
dw 0xAA55