	bits 64
	default rel

segment .data
	msg_open	db	"open", 0

segment .text
	global main
	extern ExitProcess
	extern ShellExecuteA

main:
	push    rbp
	mov     rbp, rsp
	
	push	0x5
	push	0x0
	xor	r9, r9

	sub	rsp, 8
	mov	byte [rsp], "n"
	mov	byte [rsp+1], "o"
	mov	byte [rsp+2], "t"
	mov	byte [rsp+3], "e"
	mov	byte [rsp+4], "p"
	mov	byte [rsp+5], "a"
	mov	byte [rsp+6], "d"
	mov	byte [rsp+7], 0x0	
	lea	r8, [rsp]
	add	rsp, 8
	
	lea	rdx, [msg_open]	
	xor	rcx, rcx	

	sub	rsp, 32
	call	ShellExecuteA
	add	rsp, 32

	xor     rax, rax
	call    ExitProcess
