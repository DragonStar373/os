global _start
section .text
_start:
	push 21			;
	call times2		;
	mov ebx, eax		;
	mov eax, 1		;
	int 0x80		;
times2:
	push ebp		;--save current ebp version
	mov ebp, esp		;--Prologue of the function
	mov eax, [ebp+8]	;access what was in the stack just before the actions we just added
	add eax, eax		;
	mov esp, ebp		;--Epilogue
	pop ebp			;--return old ebp version
	ret			;--
