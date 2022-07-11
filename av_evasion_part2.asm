	bits 64
	default rel

segment .data
	msg_open	db	"open", 0
	msg_notepad	db	"notepad", 0
	;; str_shell32	db	"shell32.dll", 0     ; Declaration of these string are not needed anymore
	;; str_shexa	db	"ShellExecuteA", 0   ; Because we're already adding these to the stack (See Part 1)

segment .text
	global main
	extern ExitProcess
	extern LoadLibraryA
	extern GetProcAddress

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
	
	;; = START LOADLIBRARY ===========================================
	
	sub	rsp, 16         ; Place "shell32.dll" string to the stack
	addstr2stack "s", "h", "e", "l", "l", "3", "2", ".", "d", "l", "l", 0x0 
	lea	rcx, [rsp]

	sub	rsp, 32
	call	LoadLibraryA    ; Call LoadLibraryA
	add	rsp, 32

	add	rsp, 16		; Release "shell32.dll" string from stack
	
	;; = END LOADLIBRARY ===========================================
	
	
	;; = START GETPROCADDRESS ===========================================
	
	mov	rcx, rax        ; Save value to rcx (1st parameter register)

	sub	rsp, 16         ; Place "ShellExecuteA" string to the stack
	addstr2stack "S", "h", "e", "l", "l", "E", "x", "e", "c", "u", "t", "e", "A", 0x0
	lea	rdx, [rsp]

 	sub	rsp, 32
	call	GetProcAddress	; Call GetProcAddress
	add	rsp, 32

	add	rsp, 16  	; Release "ShellExecuteA" from stack
	
	;; = END GETPROCADDRESS ===========================================
	
	
	;; = START SHELLEXECUTEA ===========================================
	
	mov	r12, rax	; Save address of "ShellExecuteA" to r12 (To be called later)

	sub	rsp, 16         ; Place "notepad" string to the stack
	addstr2stack "n", "o", "t", "e", "p", "a", "d", 0x0;; , "n", "o", "t", "e", "p", "a", "d", 0x0
	lea	r8, [rsp]

	push	0x5
	push	0x0
	xor	r9, r9

	lea	rdx, [msg_open]	
	xor	rcx, rcx

	sub	rsp, 32
	call	r12         	; Call "ShellExecuteA", jump to addres
	add	rsp, 32

	add	rsp, 16         ; Release "notepad" string from stack
	
	;; = END SHELLEXECUTEA ===========================================

	xor     rax, rax
	call    ExitProcess
