[org 0x7C00]

mov ah, 0x0e    ; tty mode (teletype mode)
mov bx, var

loop:					;Prints the string in var (Hello Worlds!)
    mov al, [bx]
    cmp byte [bx], 0
    je read
    int 0x10       ; Print character in al
    inc bx
    jmp loop

read:					;
	mov bx, inp
	mov cx, 0

readloop:
    mov ah, 0      ; Wait for keypress
    int 0x16
    mov [bx], al
    cmp cx, 16
    je postread
    inc cx
    inc bx
    jmp readloop

    

postread:
	inc bx
	mov byte [bx], 0

    mov ah, 0
	mov al, 0x03
	int 0x10

	mov ah, 0x0e    ; tty mode (teletype mode)
	mov bx, inp

echoloop:
    mov al, [bx]
    cmp byte [bx], 0
    je end
    int 0x10       ; Print character in al
    inc bx
    jmp echoloop

end:

jmp $              ; Infinite loop to stop execution here

var:
    db "Hello Worlds!", 0

inp:
    times 64 db 0

times 510-($-$$) db 0
dw 0xAA55
