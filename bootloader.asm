[org 0x7c00]
[BITS 16]
mov ah, 0x00
mov al, 0x03
int 0x10
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x9000    ; This should be safe for the time you are in this initial boot

; Save boot drive that BIOS provided
mov [boot_drive], dl

; LOADING KERNEL
kernel:
    ; First set ES so you can use AX for interrupt later
    ; For kernel at 0x10000 you need ES:BX = 0x1000:0x0000
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000
    ; mov si, 0   ; You don't need SI
    mov ah, 0x02
    mov al, 4     ; Increase if kernel size > 2 sectors - 1 sector = 512 bytes
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    int 0x13
    jc disk_error
    ; jmp kernel  ; You don't jump back again since you specify all sectors to read
                  ; The only thing to watch out for is to not exceed the max sector
                  ; of the drive geometry which might then fail. So when you start at 
                  ; sector 2 and the drive has max of 63 you can safely read 62. Or on a
                  ; standard floppy with 36 you can read 35.

    ; Clear the used segment
    xor ax, ax
    mov es, ax
   

; LET'S GO IN PROTECTED MODE
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode
    
    
; Boot drive
boot_drive:
    db 0

; GDT
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
gdt_descriptor: 
    dw gdt_end - gdt_start - 1
    dd gdt_start



; PROTECTED MODE

[BITS 32]

protected_mode:
    mov ax, 10h
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    
    ; Far jump to kernel
    jmp 0x08:0x10000

halt:
    jmp halt

disk_error:
    mov si, disk_msg

disk_loop:
    lodsb
    mov ah, 0x0e
    int 0x10
    cmp al, 0
    je halt
    jmp disk_loop

disk_msg db "Oh no! Disk Error!! :(", 0

times 510-($-$$) db 0
dw 0xAA55