[org 0x7C00]

mov ah, 0x0e	;tty mode (teletype mode)
mov bx, var

loop:
	mov al, [bx]
	cmp byte [bx], 0
	je end
	inc bx
	int 0x10
	jmp loop

end:

jmp $

var:
	db "Hello Worlds!", 0

times 510-($-$$) db 0
dw 0xAA55
