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

	sub	rsp, 16		; Reserve "notepad" string on stack
	addstr2stack "n", "o", "t", "e", "p", "a", "d", 0x0
	lea	r8, [rsp]	; lpFile (Argument 3)
	
	push	0x5		; nShowCmd (Argument 6), 0x5 == SW_SHOW
	push	0x0		; lpDirectory (Argument 5)
	xor	r9, r9		; lpParameters (Argument 4)
	
	lea	rdx, [msg_open]	; lpOperation (Argument 2)
	xor	rcx, rcx	; hwnd (Argument 1) 

	sub	rsp, 32
	call	ShellExecuteA
	add	rsp, 32

	add	rsp, 16		; Release "notepad" string from stack

	xor     rax, rax
	call    ExitProcess
