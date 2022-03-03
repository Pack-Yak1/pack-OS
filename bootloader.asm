[org 0x7c00]            ; Location of this body of code on RAM

; mov bp, 0x9000
; mov sp, bp

mov bx, MSG_REAL_MODE
call print

call switch_to_pm
jmp $                    ; Never executes

%include "boot_utils/boot_sect_print.asm"
%include "boot_utils/boot_sect_print_hex.asm"
%include "pm_utils/32bit-gdt.asm"
%include "pm_utils/32bit-switch.asm"
%include "pm_utils/32bit-print.asm"

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Bootloader started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; Ensure recognizable as boot sector
times 510-($-$$) db 0
dw 0xaa55