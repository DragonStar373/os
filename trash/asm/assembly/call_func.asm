global _start

_start:
	call func		;pushes current instruction location to stack, calls function "func" which will set ebx
	mov eax, 1		;sets system_exit syscall, notice we dont set ebx for the exit_status. we will do that in func
	int 0x80		;executes syscall

func:
	mov ebx, 42		;sets ebx to 42, which will be used as exit_status
	pop eax			;puts the last thing on the stack (instruction location after "call") into eax
	jmp eax			;jumps to eax (which happens to be the location immediately after "call")

funcc:
	mov ebx, 42
	ret			; does the same thing as the "pop" and "jmp" lines in "func:"
