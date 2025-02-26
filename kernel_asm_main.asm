[bits 32]
section .text
global asm_main
FRAMEBUFFER_LOCATION equ 0x600
FB_XLEN equ 3072
FB_YLEN equ 768
MAGIC_NUMBER1 equ 8
MAGIC_NUMBER2 equ 6
asm_main:
mov edi, [FRAMEBUFFER_LOCATION]
mov [framebuffer], edi
;mov dword [edi], 0x00FF00  ; Write a green pixel (24-bit color)

mov eax, edi
add eax, FB_XLEN
mov ebx, 1

mov byte dl, 0x00   ;red value
mov byte dh, 0x88   ;green value
mov byte cl, 0x00   ;blue value

mov byte ch, 0x00   ;x-value change counter
mov byte si, 0x00   ;y-value change counter

output_loop:
mov byte [edi], dl      ;mov blue value to pixel
mov byte [edi + 1], dh  ;mov green value to pixel
mov byte [edi + 2], cl  ;mov red value to pixel
add edi, 3      ;next pixel
output_loop_calculating:
inc ch
cmp ch, MAGIC_NUMBER1
jge reset_ch
jmp dont_reset_ch
reset_ch:
mov byte ch, 0x00
dec dh      ;decrease green
dont_reset_ch:
cmp edi, eax
jge new_line
jmp output_loop

new_line:
mov byte ch, 0x00
mov byte dh, 0x88
add eax, 3072
;add eax, FB_XLEN
inc ebx
;add edi, 3072

new_line_calculating:
inc si
cmp si, MAGIC_NUMBER2
jge reset_si
jmp dont_reset_si
reset_si:
mov byte si, 0x00
inc dl          ;increase blue value (every line change)
dont_reset_si:
cmp ebx, FB_YLEN
jge finished
jmp output_loop

finished:
;eax = final location, edi = x location, ebx = y location, cx / dx = counters

;mov edi, [FRAMEBUFFER_LOCATION]

;a_loop:




mov edi, [FRAMEBUFFER_LOCATION]
mov dword ebx, 500


mov eax, 3072
mul ebx
add edi, eax
add edi, 600



draw_square1:
mov byte cl, 0x00
mov byte ch, 0x20
s1_top_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge s1_sides
jmp s1_top_loop
s1_sides:
mov byte [edi], 0xDD    ;finishing last pixel
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD

mov byte cl, 0x00
mov byte ch, 0x20
add edi, 2976
s1_sides_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 96
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 2976
inc cl
cmp cl, ch
jge s1_bottom
jmp s1_sides_loop
s1_bottom:
mov byte cl, 0x00
mov byte ch, 0x20
s1_bottom_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge s1_end
jmp s1_bottom_loop
s1_end:
mov byte [edi], 0xDD
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD




mov edi, [FRAMEBUFFER_LOCATION]
mov dword ebx, 500


mov eax, 3072
mul ebx
add edi, eax
add edi, 792



draw_square2:
mov byte cl, 0x00
mov byte ch, 0x20
s2_top_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge s2_sides
jmp s2_top_loop
s2_sides:
mov byte [edi], 0xDD    ;finishing last pixel
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD

mov byte cl, 0x00
mov byte ch, 0x20
add edi, 2976
s2_sides_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 96
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 2976
inc cl
cmp cl, ch
jge s2_bottom
jmp s2_sides_loop
s2_bottom:
mov byte cl, 0x00
mov byte ch, 0x20
s2_bottom_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge s2_end
jmp s2_bottom_loop
s2_end:
mov byte [edi], 0xDD
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD



mov edi, [FRAMEBUFFER_LOCATION]
mov dword ebx, 430


mov eax, 3072
mul ebx
add edi, eax
add edi, 696



draw_rect1:
mov byte cl, 0x00
mov byte ch, 0x20
r1_top_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge r1_sides
jmp r1_top_loop
r1_sides:
mov byte [edi], 0xDD    ;finishing last pixel
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD

mov byte cl, 0x00
mov byte ch, 0x45
add edi, 2976
r1_sides_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 96
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 2976
inc cl
cmp cl, ch
jge r1_bottom
jmp r1_sides_loop
r1_bottom:
mov byte cl, 0x00
mov byte ch, 0x20
r1_bottom_loop:
mov byte [edi], 0xDD      ;mov blue value to pixel
mov byte [edi + 1], 0xDD  ;mov green value to pixel
mov byte [edi + 2], 0xDD  ;mov red value to pixel
add edi, 3
inc cl
cmp cl, ch
jge r1_end
jmp r1_bottom_loop
r1_end:
mov byte [edi], 0xDD
mov byte [edi + 1], 0xDD
mov byte [edi + 2], 0xDD


jmp $

ret


framebuffer:
    times 1 db 0
color1:
    times 1 db 0
color2:
    times 1 db 0
color3:
    times 1 db 0