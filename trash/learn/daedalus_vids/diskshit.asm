[org 0x7C00]
global _start
section .data
    disknum db 0x0000
section .text
_start:
    mov [disknum], dl
    call loadDisk
    jmp end

loadDisk:
    xor ax, ax      ; Clear ax to zero
    mov es, ax
    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [disknum]
    mov bx, 0x7e00
    int 0x13
    ret

    ;   ideal layout, but cannot move 0 directly into es
    ;mov ah, 2
    ;mov al, 1
    ;mov ch, 0
    ;mov cl, 0
    ;mov dh, 0
    ;mov dl, [disknum]
    ;mov es, 0
    ;mov bx, 0x7e00
    ;int 0x13
    ;ret

end:
    mov ah, 0x0e ;TTY
    mov al, [0x7e00]
    int 0x10

jmp $

times 510-($-$$) db 0
dw 0x55AA
times 512 db 'F'    ;THIS GOES AFTER THE MAGIC BOOT NUMBER -- ANOTHER SECTOR ENTIRELY
