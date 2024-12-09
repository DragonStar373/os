[bits 32]
[extern main]
mov al, 'O'
mov ah, 0x0f
mov [0xb8000], ax

call main
jmp $
