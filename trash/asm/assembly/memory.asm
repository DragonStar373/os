global _start
section .data
	addr db "yellow"	;new label called 'addr' which contains a string with the text "yellow" (db = databyte)
section .text
_start:
	mov [addr], byte 'H'	;changes data in addr
	mov [addr+5], byte '!'
	mov eax, 4		;sys_write syscall
	mov ebx, 1		;stdout file descriptor (stdout = 'standard out' (or 'standard ouput'?))
	mov ecx, addr		;bytes to write
	mov edx, 6		;number of bytes to write (ik there's a better way)
	int 0x80		;interrupt, executes sys_write syscall (DOES NOT EXIT PROGRAM!)
	mov eax, 1		;sys_exit syscall
	mov ebx, 0		;exit_status is 0
	int 0x80		;interrupt, executes sys_exit with exit_status 1 (now, we exit program)
