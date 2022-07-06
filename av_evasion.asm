	bits 64
	default rel

segment .text
	global main
	extern ExitProcess

main:
	push    rbp
	mov     rbp, rsp

	xor     rax, rax
	call    ExitProcess
