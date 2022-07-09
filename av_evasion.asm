	bits 64
	default rel

segment .data
	msg_open	db	"open", 0
	;; str_shell32	db	"shell32.dll", 0
	;; str_shexa	db	"ShellExecuteA", 0

segment .text
	global main
	extern ExitProcess
	extern ShellExecuteA
	extern LoadLibraryA
	extern GetProcAddress
	extern MessageBoxA

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
 	sub	rsp, 32

	sub	rsp, 16
	addstr2stack "s", "h", "e", "l", "l", "3", "2", ".", "d", "l", "l", 0x0
	lea	rcx, [rsp]

	;; lea	rcx, [str_shell32]
	sub	rsp, 32
	call	LoadLibraryA
	add	rsp, 32

	add	rsp, 16		; Release shell32.dll
	
	mov	rcx, rax

	sub	rsp, 16
	addstr2stack "S", "h", "e", "l", "l", "E", "x", "e", "c", "u", "t", "e", "A", 0x0
	lea	rdx, [rsp]

	;; lea	rdx, [str_shexa]
 	sub	rsp, 32
	call	GetProcAddress
	add	rsp, 32

	add	rsp, 16  	; Release ShellExecuteA

	mov	rbx, rax

	;; push	rax
	;; xor	r9, r9
	;; lea	r8, [str_shexa]
	;; lea	rdx, [str_shexa]
	;; xor	rcx, rcx
	;; sub	rsp, 32
	;; call	rax
	;; add	rsp, 32
	;; pop	rax

	;; xor	r9, r9
	;; lea	r8, [str_shexa]
	;; lea	rdx, [str_shexa]	
	;; xor	rcx, rcx
	;; sub	rsp, 32
	;; call	rax
	;; add	rsp, 32
	
	push	0x5
	push	0x0
	xor	r9, r9

	sub	rsp, 8
	addstr2stack "n", "o", "t", "e", "p", "a", "d", 0x0
	lea	r8, [rsp]
	add	rsp, 8

	;; sub	rsp, 16
	;; addstr2stack "p", "o", "w", "e", "r", "s", "h", "e", "l", "l", 0x0
	;; lea	r8, [rsp]
	;; add	rsp, 16
	
	lea	rdx, [msg_open]	
	xor	rcx, rcx

	sub	rsp, 32
	call	rbx
	add	rsp, 32

	xor     rax, rax
	call    ExitProcess
