; Bootloader using NASM for x86 architecture
[org 0x7C00]

; Define data section
section .data
string_db 'Hello World!', 0

; Define code (text) section
section .text
global _start:function _start

_start:
    ; Set up the stack and DS register
    mov ax, 0x07C0
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

; Clear the screen using BIOS Int 10h function 0h
mov ah, 0
mov al, 0x03
int 0x10

; Set up the video display (80x25 text mode)
mov ax, 0x03
int 0x10

; Loop to print and repeat the string indefinitely
.loop:
    ; Print the string
    mov ah, 0x0E ; TTY output
    mov bp, string_db
    mov cx, lengthof(string_db)
.print:
    lodsb
    int 0x10 ; BIOS Teletype function call
    jnz .print

    ; Wait for user input (press any key to continue)
    mov ah, 0
    int 0x16
    jz .loop

; Halt the CPU
hlt
times 510-($-$$) db 0x90
dw 0xAA55

