global _start

section .text
_start:
	mov eax, 1	;eax = sys_exit syscall
	mov ebx, 1	;initial value of ebx, will be doubled each iteration of the loop label
	mov ecx, 4	;number of iterations by which to double ebx; effectively the power of two
loop:
	add ebx, ebx	;ebx += ebx
	dec ecx		;decrement ecx, ecx -= 1
	cmp ecx, 0	;compare ecx with 0, returns a (greater, equal, less/equal, etc value) to background register
	jg loop		;jump to "loop" label if greater (reads from said background register)
	int 0x80	;runs sys_exit syscall, returns exit status of ebx (which we doubled each iteration of "loop"
