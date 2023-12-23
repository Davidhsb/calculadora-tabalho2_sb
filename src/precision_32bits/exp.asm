SECTION .text
global	exp_32

extern	getdw, putdw, puts
extern	overflow

; Lê dois números inteiros e imprime o resultado da exponenciação do primeiro pelo segundo.

%define number1 dword [EBP-4]
exp_32:
	enter 4, 0
	call	getdw
	mov		number1, eax
	call	getdw

	cmp		eax, 0
	jl  	ltz1

	mov 	ecx, eax
	mov 	eax, 1
  ls1:
    test ecx, ecx
    jz   le1
    imul number1
    jo   overflow_loop
    dec  ecx
    jmp  ls1

  ltz1:
    mov 	eax, 0
  le1:
    push	eax
    call	putdw
    leave
    ret

  overflow_loop:
    push	overflow
    call	puts
    mov		eax, 1
    mov		ebx, 1
    int		0x80