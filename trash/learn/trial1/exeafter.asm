[org 0x7c00]
;	this is me doing my own thing

global _start

section .data
bootdisknum:
	db 0x00
section .text
_start:
	mov [bootdisknum], dl
	call load
	jmp execute7e00

load:
	xor ax, ax	;clear ax
	mov es, ax	;ensures es is 0, so that we are not offsetting our memory location for loading the next sector

	mov ah, 2	;ah contains the (sector?)
	mov al, 1	;# of sectors to load
	mov bx, 0x7e00	;location in memory to load disk (or bin) contents
	mov ch, 0	;cyl #
	mov cl, 2	;sector # (same as ah?)
	mov dh, 0	;head #
	mov dl, [bootdisknum]	;drive #

	int 0x13
	ret

execute7e00:
	jmp 0x7e00


times 510-($-$$) db 0
db 0x55, 0xaa
