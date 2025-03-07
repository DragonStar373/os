[org 0xc00]
FRAMEBUFFER_LOCATION equ 0x600
ENTRY_LOCATION equ 0x2000

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
	jmp ENTRY_LOCATION

vbe_info_buffer:
    times 512 db 0   ; Reserve 128 bytes

vbe_mode_info_buffer:
    times 256 db 0   ; Reserve 64 bytes

framebuffer:
    times 8 db 0


times 5120-($-$$) db 0     ;;makes boot2.bin 5kb large, ie 10 sectors (sector = 512 bytes)
