[org 0x7C00]
global _start
section .data

section .text

_start:
	
	; this space will be used for setting up the stack
	
	
	mov ah, 0	; learned this from gpt, but supposedly clears the screen using BIOS Int 10h function 0h
	mov al, 0x03
	int 0x10
