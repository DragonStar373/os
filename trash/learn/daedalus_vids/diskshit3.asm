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

printStatement:
	mov ah, 0x0e	;tty
	mov bx, 0x7e00
	cmp byte [bx], 0x00
	je execute7e00

pS_Loop:
	mov al, [bx]
	int 0x10
	inc bx
	cmp byte [bx], 0x00
	je execute7e00
	jmp pS_Loop

execute7e00:
	jmp 0x7e00


times 510-($-$$) db 0
db 0x55, 0xaa

;at this point we begin a new sector entirely

mov ah, 0x0e
mov al, '6'
int 0x10
mov al, '9'
int 0x10
jmp $

times 1547 db 0
