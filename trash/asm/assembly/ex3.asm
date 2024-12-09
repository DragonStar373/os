global _start

section .text
_start:
	mov eax, 1	;eax holds the system call to be executed (in this case, 1, which is sys_exit syscall)
	mov ebx, 99	;ebx hold the first argument for the system call (currently sys_exit, so first arg is exit_status)
	jmp skip	;jumps to a later label called "skip." any commands after this will not be executed unless jmped to agian.
	mov ebx, 13	;changes the exit_status arg to 13. Won't be executed, as jmp command is before it.
skip:
	int 0x80	;performs interrupt 0x80, which executes the syscall in eax (sys_exit, with arg 99 for exit status)
