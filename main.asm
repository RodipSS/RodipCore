[org 0x7c00]
[BITS 16]
mov si, msg
;PRINTING

listen:
    lodsb
    mov ah, 0x0e
    int 0x10
    cmp al, 0
    je kernel
    jmp listen
print_String:
    msg db "Hello World! (from bootloader btw)", 0Ah, 0Dh, 0

;LOADING KERNEL
xor ax, ax
kernel:

    mov si, 0
    mov ah, 0x02
    mov al, 8
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80
    mov bx, 0x1000
    mov es, ax
    int 0x13
    jc disk_error

;TRYING SOMETHING NAMED LIKE "PROTECTED MODE'
gdt_start:
gdt_null: dd 0,0
gdt_code: dw 0xffff
            dw 0
            db 0
            db 10011010b
            db 11001111b
            db 0
gdt_data: dw 0xffff
            dw 0
            db 0
            db 10010010b
            db 11001111b
            db 0
gdt_end:
gdt_descryptor: 
    dw gdt_end - gdt_start - 1
    dd gdt_start
;LET'S GO IN PROTECTED MODE
    cli
    lgdt [gdt_descryptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 08h:protected_mode
;PROTECTED MODE
[BITS 32]
mov ebx, 0x1000
protected_mode:
    mov ax, 10h
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    jmp 0x1000
.halt: jmp .halt
disk_error:
    mov si, disk_msg
disk_msg db "Oh no! Disk Error!! :(", 0Ah, 0Dh, 0
times 510-($-$$) db 0
dw 0xAA55