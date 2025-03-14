[bits 32]
FRAMEBUFFER_LOCATION_PTR equ 0x7e01
VBE_PIXEL_PTR equ 0x7e05
global print_char_anywhere

;more refined version of print_char_anywhere -
print_char:

; char value will be saved to 0x7df0 (1 byte), offset value will be in 0x7e05 (4 bytes) (offset needs to be multiplied by 3 !!!)
print_char_anywhere:
    mov edi, [FRAMEBUFFER_LOCATION_PTR]     ;edi will be the final pointer
    mov dword eax, [VBE_PIXEL_PTR]
    mov dword ebx, 3                        ;mul instruction always multiplies by eax, so we need to put multiplier in another register
    mul ebx
    add edi, eax                            ;edi is now the start of the framebuffer + the amount of pixels we've moved past now

    mov byte bl, [0x7df0]
    cmp bl, 'A'
    je print_A
    cmp bl, 'B'
    je print_B
    cmp bl, 'C'
    je print_C
    cmp bl, 'D'
    je print_D
    cmp bl, 'E'
    je print_E
    cmp bl, 'F'
    je print_F
    ret

finished_sucessfully:
    mov eax, [VBE_PIXEL_PTR]
    add eax, 8
    mov [VBE_PIXEL_PTR], eax
    ret


print_F:
    add edi, 3075
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully

print_E:
    add edi, 3075
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully

print_D:
    add edi, 3075
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3063
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 12
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3060
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 12
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3060
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully
print_C:
    add edi, 3078
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3072
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3075
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully


print_B:
    add edi, 3075
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3060
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3060
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully


print_A:

    add edi, 3078
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3063
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 9
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3060
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 9
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 3057
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD
    add edi, 15
    mov byte [edi], 0xDD
    mov byte [edi + 1], 0xDD
    mov byte [edi + 2], 0xDD

    jmp finished_sucessfully

vbepixel:
    times 4 db 0