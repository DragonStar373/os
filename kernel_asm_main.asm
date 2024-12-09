[bits 32]
section .text
global asm_main
asm_main:
mov al, 'A'
	mov ah, 0b00001111
	mov [0xb8000], ax

jmp $

ret


