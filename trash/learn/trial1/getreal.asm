[org 0x7c00]

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start


cli	;disables all interrupts
lgdt[GDT_Descriptor]

mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:Start_PM

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
Start_PM:
	mov al, 'A'
	mov ah, 0x0f
	mov [0xb8000], ax
	jmp $

BOOT_DISK: db 0

times 510-($-$$) db 0
dw 0xaa55
