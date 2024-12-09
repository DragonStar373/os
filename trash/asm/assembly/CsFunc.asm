global CsFunc
CsFunc:
	push ebp		;--	save old ebp to stack
	mov ebp, esp		;--	save stack pointer to ebp
	mov eax, [ebp+8]	;access what was in stack before calling csfunc
	add eax, 69		;add 69 to it (THIS FUNC ADDS 69 TO NUMBER lol)
	mov esp, ebp		;--	go back to stack location at end of prologue
	pop ebp			;--	restore stack to same location from before function
	ret			;--	byebye
