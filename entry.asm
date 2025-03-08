[bits 32]
[extern main]
[extern asm_main]


call asm_main
call main
jmp $
