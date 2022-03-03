; Expect data to print in 'dx'. prints 2 bytes in 0x____ format

print_hex:
    pusha     ; save all registers
    mov cx, 0 ; index variable

; To convert a hexadecimal digit to its ascii char:
; Between 0 to 9: add 0x30 to the byte ('0' = 0x30, '9' = 0x39)
; Between A to F: add 0x40 to the byte ('A' = 65 = 0x41)
hex_loop:
    cmp cx, 4 ; loop 4 times
    je end

    ; Convert last char of 'dx' to ascii
    mov ax, dx
    and ax, 0x000f ; bitmask for last nibble
    add al, 0x30
    cmp al, 0x39
    jle step2
    add al, 7 ; 0x41 - 0x39 = 7
    jmp step2

step2:
    ; Place byte in correct place in bx for print call
    mov bx, HEX_OUT + 5 ; start from right side of output buffer
    sub bx, cx          ; step left to the next char to write
    mov [bx], al        ; write char we stored in `al` to `bx`
    ror dx, 4           ; rotate input to put next char in LSB

    add cx, 1           ; increment index
    jmp hex_loop

end:
    mov bx, HEX_OUT     ; prepare arg for print
    call print

    popa                ; restore all registers
    ret

HEX_OUT:
    db '0x0000', 0      ; buffer to store printed string