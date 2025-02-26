[bits 32]
section .text
global asm_main
FRAMEBUFFER_LOCATION equ 0x600
FB_XLEN equ 0x900
FB_YLEN equ 0x400
asm_main:
mov edi, [FRAMEBUFFER_LOCATION]
mov [framebuffer], edi
;mov dword [edi], 0x00FF00  ; Write a green pixel (24-bit color)

mov eax, edi
add eax, FB_XLEN
mov ebx, 1
output_loop:
mov byte [edi], 0x00
inc edi
mov byte [edi], 0xFF
inc edi
mov byte [edi], 0x00
inc edi
;cmp edi, eax
;jge new_line
jmp output_loop
new_line:
inc ebx
cmp ebx, FB_YLEN
jge finished
jmp output_loop

finished:

framebuffer:
    times 8 db 0

jmp $

ret


