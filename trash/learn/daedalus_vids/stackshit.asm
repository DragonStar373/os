[org 0x7C00]
global _start

section .text
_start:
    mov bp, 0x8000
    mov sp, bp
times 510-($-$$) db 0
dw 0xAA55