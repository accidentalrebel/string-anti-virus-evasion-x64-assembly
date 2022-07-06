	bits 64
	default rel

segment .data
	msg_open	db	"open", 0
	msg_notepad	db	"notepad", 0

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
	lea	r8, [msg_notepad]	
	lea	rdx, [msg_open]	
	xor	rcx, rcx	

	sub	rsp, 32
	call	ShellExecuteA
	add	rsp, 32

	xor     rax, rax
	call    ExitProcess
