print:
    pusha ; save all registers


start:
    mov al, [bx] ; bx contains a pointer to string to print
    cmp al, 0    ; check for null byte terminator
    je done

    mov ah, 0x0e ; print character
    int 0x10

    add bx, 1    ; move to next char in string
    jmp start

done:
    popa         ; restore all registers
    ret



print_newline:
    pusha ; save all registers

    mov ah, 0x0e
    mov al, 0x0a ; newline
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa ; restore all registers
    ret