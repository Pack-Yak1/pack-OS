[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f


; Requires: `[ebx]` contains pointer to string to print
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_string_pm_done

    mov [edx], ax
    add ebx, 1 ; shift input pointer to next char to print
    add edx, 2 ; next video memory position, video memory is 2 byte/char

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret

    