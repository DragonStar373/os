global _start
section .data
	deez db "arson!", 0xA, 0xD
	deezLen equ $-deez
	newLineMsg db 0xA, 0xD
	newLineLen equ $-newLineMsg
section .text
_start:
	mov eax, 4		; sys_write system call
	mov ebx, 1		; stdout file descriptor
	mov ecx, deez		; indubitably, *deez*
	mov edx, deezLen	; number of bytes to write
	int 0x80		; perform sys_write syscall
	mov eax, 1		; sys_exit syscall
	mov ebx, 0		; exit_status
	int 0x80		; perform sys_exit syscall, with exit_status 0
