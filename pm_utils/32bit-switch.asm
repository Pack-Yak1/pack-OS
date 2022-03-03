[bits 16]

; Requires: called with `gdt_descriptor` and `CODE_SEG` address defined

switch_to_pm:
    cli ; disable interrupts
    lgdt [gdt_descriptor] ; load GDT
    
    mov eax, cr0 ; set 32-bit mode bit in cr0
    or eax, 0x1 
    mov cr0, eax

    jmp CODE_SEG:init_pm ; far jump into code segment, forces CPU to flush insns

[bits 32]
init_pm: 
    ; update segment registers as real mode segments now invalid
    mov ax, DATA_SEG 
    mov ds, ax  
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; put base of stack at the top of free space
    mov esp, ebp     ; stack pointer starts at base

    call BEGIN_PM




