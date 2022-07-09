	bits 64
	default rel

segment .data
	msg_open	db	"open", 0

segment .text
	global main
	extern ExitProcess
	extern ShellExecuteA

%macro	addstr2stack	1-*
	%assign	i 0
	%assign j 0
	%rep	%0
 		mov	byte [rsp+i+8*j], %1
		%assign	i i+1
		%rotate 1

		%if i >= 8
			%assign j j+1
			%assign i 0
		%endif
	%endrep
%endmacro

main:
	push    rbp
	mov     rbp, rsp
	
	push	0x5
	push	0x0
	xor	r9, r9

	;; sub	rsp, 8
	;; addstr2stack "n", "o", "t", "e", "p", "a", "d", 0x0
	;; lea	r8, [rsp]
	;; add	rsp, 8

	sub	rsp, 16
	addstr2stack "p", "o", "w", "e", "r", "s", "h", "e", "l", "l", 0x0
	lea	r8, [rsp]
	add	rsp, 16
	
	lea	rdx, [msg_open]	
	xor	rcx, rcx	

	sub	rsp, 32
	call	ShellExecuteA
	add	rsp, 32

	xor     rax, rax
	call    ExitProcess
