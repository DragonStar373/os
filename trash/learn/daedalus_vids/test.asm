[org 0x7c00]
global _start
section .data
bootdisk:
	db 0x00
section .text
_start:
	jmp $

times 510-($-$$) db 0
db 0x55, 0xaa
times 512 db 'a'
