; Flags selected with reference to osdev book

gdt_start:
    ; GDT starts with 8 null bytes
    dd 0x0
    dd 0x0

; GDT for code segment. base = 0x00000000, length = 0xfffff
gdt_code:
    dw 0xffff ; segment length lower 2 bytes [15:00]
    dw 0x0 ; segment base, lower 2 bytes [15:00]
    db 0x0 ; segment base, 2nd highest byte [23:16]
    db 10011010b ; flags, 8 bits
    db 11001111b ; flags, 4 bits and segment length [19:16]
    db 0x0 ; segment base, highest byte [31:24]

; GDT for data segment
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of GDT - 1 (16-bit)
    dd gdt_start ; address of GDT (32-bit)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

