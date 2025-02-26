[org 0x7c00]
KERNEL_LOCATION equ 0x1000
FRAMEBUFFER_LOCATION equ 0x600

mov [BOOT_DISK], dl


; 1) load the disk


xor ax, ax	;clear ax
mov es, ax	;ensures es is 0, so that we are not offsetting our memory location for loading the next sector
mov ds, ax		;idrk what this is for
mov bp, 0x8000		;idrk what this is for
mov sp, bp		;idrk what this is for

;mov ah, 2	;ah contains the (sector?)
;mov al, 20	;# of sectors to load			; I CHANGED THIS TO 20
;mov bx, KERNEL_LOCATION	;location in memory to load disk (or bin) contents
;mov ch, 0	;cyl #
;mov cl, 2	;sector # (same as ah?)
;mov dh, 0	;head #
;mov dl, [BOOT_DISK]	;drive #


mov bx, KERNEL_LOCATION
mov dh, 2

mov ah, 0x02
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]


int 0x13         ; Interrupt for disk read
jc read_error    ; Jump if carry flag is set (error)
jmp no_error     ; Continue if no error

read_error:
; Handle error here - this could involve printing an error message and halting
mov ah, 0x0e
mov al, 'D'      ; Display an 'E' for error
int 0x10
mov al, 'i'      ; Display an 'E' for error
int 0x10
mov al, 's'      ; Display an 'E' for error
int 0x10
mov al, 'k'      ; Display an 'E' for error
int 0x10
mov al, ' '      ; Display an 'E' for error
int 0x10
mov al, 'R'      ; Display an 'E' for error
int 0x10
mov al, 'e'      ; Display an 'E' for error
int 0x10
mov al, 'a'      ; Display an 'E' for error
int 0x10
mov al, 'd'      ; Display an 'E' for error
int 0x10
mov al, ' '      ; Display an 'E' for error
int 0x10
mov al, 'E'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
mov al, 'o'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
jmp $            ; Hang the system or loop back to retry

no_error:


; 2) clear the screen

;mov ah, 0x0
;mov al, 0x3
;int 0x10	;enters text mode, clears the screen

mov ax, 0x4F00  ; VBE function to get VBE controller info
mov di, vbe_info_buffer  ; Store output here
int 0x10        ; Call BIOS

mov ax, 0x4F01  ; Get specific mode info
mov cx, 0x0118  ; Example: 1024x768 mode
mov di, vbe_mode_info_buffer  ; Store output here
int 0x10

mov ax, 0x4F02  ; Set video mode
mov bx, 0x0118  ; 1024x768 24-bit color
or  bx, 0x4000  ; Enable linear framebuffer
int 0x10


; 3) switch to PM

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start


cli	;disables all interrupts
lgdt [GDT_Descriptor]

mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:start_protected_mode

jmp $	;I assume this is here purely for safety's sake

BOOT_DISK: db 0

;must be at the end of real mode code for some reason
GDT_Start:
	null_descriptor:
		dd 0x0
		dd 0x0
	code_descriptor:
		dw 0xffff
		dw 0x0
		db 0x0
		db 0b10011010
		db 0b11001111
		db 0x0
	data_descriptor:
		dw 0xffff
		dw 0x0
		db 0x0
		db 0b10010010
		db 0b10010010
		db 0x0

GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1
	dd GDT_Start


[bits 32]
start_protected_mode:
	mov ax, DATA_SEG	;set up registers or something idk
		mov ds, ax
		mov ss, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
		mov ebp, 0x90000
		mov esp, ebp

;test
	;mov al, 'A'
	;mov ah, 0x0f
	;mov [0xb8000], ax
	mov eax, dword [vbe_mode_info_buffer + 0x28]  ; Full 32-bit framebuffer address
    ;mov edi, [vbe_mode_info_buffer + 0x28]  ; Get framebuffer address
    ;mov dword [edi], 0x00FF00  ; Write a green pixel (24-bit color)
    mov [FRAMEBUFFER_LOCATION], eax



; 4) jmp to kernel3

	jmp KERNEL_LOCATION

vbe_info_buffer:
    times 128 db 0   ; Reserve 128 bytes

vbe_mode_info_buffer:
    times 64 db 0   ; Reserve 64 bytes

framebuffer:
    times 8 db 0

times 510-($-$$) db 0
dw 0xaa55



