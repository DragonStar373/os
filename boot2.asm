[org 0xc00]
FRAMEBUFFER_LOCATION equ 0x600
ENTRY_LOCATION equ 0x2000

; 2) enable A20 flag (God help us all)
call enable_a20
jmp clear_screen_set_vbe
get_a20_state:
	pushf
	push si
	push di
	push ds
	push es
	cli

	mov ax, 0x0000					;	0x0000:0x0500(0x00000500) -> ds:si
	mov ds, ax
	mov si, 0x0500

	not ax							;	0xffff:0x0510(0x00100500) -> es:di
	mov es, ax
	mov di, 0x0510

	mov al, [ds:si]					;	save old values
	mov byte [.BufferBelowMB], al
	mov al, [es:di]
	mov byte [.BufferOverMB], al

	mov ah, 1						;	check byte [0x00100500] == byte [0x0500]
	mov byte [ds:si], 0
	mov byte [es:di], 1
	mov al, [ds:si]
	cmp al, [es:di]
	jne .exit
	dec ah
.exit:
	mov al, [.BufferBelowMB]
	mov [ds:si], al
	mov al, [.BufferOverMB]
	mov [es:di], al
	shr ax, 8
	sti
	pop es
	pop ds
	pop di
	pop si
	popf
	ret

	.BufferBelowMB:	db 0
	.BufferOverMB	db 0

;	out:
;		ax - a20 support bits (bit #0 - supported on keyboard controller; bit #1 - supported with bit #1 of port 0x92)
;		cf - set on error
query_a20_support:
	push bx
	clc

	mov ax, 0x2403
	int 0x15
	jc .error

	test ah, ah
	jnz .error

	mov ax, bx
	pop bx
	ret
.error:
	stc
	pop bx
	ret

enable_a20_keyboard_controller:
	cli

	call .wait_io1
	mov al, 0xad
	out 0x64, al

	call .wait_io1
	mov al, 0xd0
	out 0x64, al

	call .wait_io2
	in al, 0x60
	push eax

	call .wait_io1
	mov al, 0xd1
	out 0x64, al

	call .wait_io1
	pop eax
	or al, 2
	out 0x60, al

	call .wait_io1
	mov al, 0xae
	out 0x64, al

	call .wait_io1
	sti
	ret
.wait_io1:
	in al, 0x64
	test al, 2
	jnz .wait_io1
	ret
.wait_io2:
	in al, 0x64
	test al, 1
	jz .wait_io2
	ret

;	out:
;		cf - set on error
enable_a20:
	clc									;	clear cf
	pusha
	mov bh, 0							;	clear bh

	call get_a20_state
	jc .fast_gate

	test ax, ax
	jnz .done

	call query_a20_support
	mov bl, al
	test bl, 1							;	enable A20 using keyboard controller
	jnz .keybord_controller

	test bl, 2							;	enable A20 using fast A20 gate
	jnz .fast_gate
.bios_int:
	mov ax, 0x2401
	int 0x15
	jc .fast_gate
	test ah, ah
	jnz .failed
	call get_a20_state
	test ax, ax
	jnz .done
.fast_gate:
	in al, 0x92
	test al, 2
	jnz .done

	or al, 2
	and al, 0xfe
	out 0x92, al

	call get_a20_state
	test ax, ax
	jnz .done

	test bh, bh							;	test if there was an attempt using the keyboard controller
	jnz .failed
.keybord_controller:
	call enable_a20_keyboard_controller
	call get_a20_state
	test ax, ax
	jnz .done

	mov bh, 1							;	flag enable attempt with keyboard controller

	test bl, 2
	jnz .fast_gate
	jmp .failed
.failed:
    mov al, 'A'
    int 0x10
    mov al, '2'
    int 0x10
    mov al, '0'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'F'
    int 0x10
    mov al, 'a'
    int 0x10
    mov al, 'i'
    int 0x10
    mov al, 'l'
    int 0x10
	jmp $
.done:
	popa
	ret




clear_screen_set_vbe:
; 3) clear the screen

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

; 4) switch to PM

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



; 5) jmp to kernel3
    ;jmp $
	jmp ENTRY_LOCATION

vbe_info_buffer:
    times 512 db 0   ; Reserve 128 bytes

vbe_mode_info_buffer:
    times 256 db 0   ; Reserve 64 bytes

framebuffer:
    times 8 db 0


times 5120-($-$$) db 0     ;;makes boot2.bin 5kb large, ie 10 sectors (sector = 512 bytes)
