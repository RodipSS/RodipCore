[org 0x7c00]
[BITS 16]

mov ah, 0x00
mov al, 3
int 0x10

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x9000

; Save boot drive that BIOS provided
mov [boot_drive], dl

kernel:
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000

    ; DAP
    mov si, dap
    mov word [dap+2], 64
    mov word [dap+4], 0x0000
    mov word [dap+6], 0x1000
    mov dword [dap+8], 1
    mov dword [dap+12], 0

    mov ah, 0x42
    mov dl, [boot_drive]
    int 0x13
    jc disk_error

    xor ax, ax
    mov es, ax

    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:kernel_start
    
    
; Boot drive
boot_drive:
    db 0

; Disk Address Packet (DAP)
dap:
    db 16
    db 0
    dw 0
    dw 0
    dw 0
    dq 0


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

kernel_start:
    mov ax, 0x10
    mov ds, ax
    mov es, ax

   ; mov dword [0xB8000], 'H' | 0x07 << 8
   ; mov dword [0xB8004], 'E' | 0x07 << 8
   ; mov dword [0xB8008], 'L' | 0x07 << 8 ; H E L L O for some tests
   ; mov dword [0xB800C], 'L' | 0x07 << 8
   ; mov dword [0xB8010], 'O' | 0x07 << 8
    jmp protected_mode
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
