[org 0x7c00]
mov ah, 0x0e
mov bx, var

loop:
	mov al, [bx]
	cmp al, 0
	je end
	int 0x10
	inc bx
	jmp loop

end:

jmp $


var:
	db "String",0

times 510-($-$$) db 0
db 0x55, 0xaa
