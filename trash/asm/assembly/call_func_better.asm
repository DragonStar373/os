global _start

_start:
	call func
	mov eax, 1
	mov ebx, 0
	int 0x80

func:
	push ebp		;	PROLOGUE pushes previous value of ebp to the stack -- in case there was already something there, ie in case this function is being called by another function
	mov ebp, esp		;	saves the current stack location to ebp (base pointer
	sub esp, 2		; subtract 2 from stack pointer, thus allocating 2 bytes
	mov [esp], byte 'H'
	mov [esp+1], byte 'i'
	mov eax, 4		;these 5 lines are standard print lines
	mov ebx, 1
	mov ecx, esp
	mov edx, 2
	int 0x80
	mov esp, ebp		;	EPILOGUE restores stack to original state
	pop ebp			;	restores ebp to what it was before the function
	ret			;	returns to correct location
