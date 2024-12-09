global _start

section .text
_start:
	mov eax, 1	;syscall = sys_exit
	mov ebx, 42	;exit_status = 42
	mov ecx, 101	;sets ecx to 101	ecx is not used as an arg for sys_exit, so it will serve as an independant variable.
	cmp ecx, 100	;compares the value of ecx(99) to the argument(100.) saves result(lessthan, greaterthan) in background flag
	jl skip		;jl = jmp if less than	checks background flag for result from our cmp operation
	mov ebx, 13	; this time, the the exit_status can be changed depending on the result of our cmp operation
skip:
	int 0x80

;	Other conditional jmp commands:
;	je 	Jump if equal
;	jne	Jump if not equal
; 	jg	Jump if greater
;	jge	Jump if greater or equal
;	jl	Jump if less
;	jle	Jump if less or equal
