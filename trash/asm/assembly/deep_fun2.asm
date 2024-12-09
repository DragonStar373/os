global main
extern printf					; we will use gcc as our linker, so that it can give us printf function to use -- asm .o and c .o files are compatible, CAN BE LINKED!

section .data
	msg db "Testing %i...", 0x0a, 0x00	;String to input into msg, followed by Linefeed and Carriage return

section .text
main:
	push ebp				;--save current ebp
	mov ebp, esp				;--move current stack pointer to ebp
	push 123				;
	push msg				;
	call printf				;first arg will be msg, second will be 123 -- reads from stack
	mov eax, 0				;This will be our exit status, as we are returnint with ret, not an int 0x80 syscall
	mov esp, ebp				;
	pop ebp					;
	ret					;
