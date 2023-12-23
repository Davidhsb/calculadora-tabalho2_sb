SECTION .text
global	exp_16

extern	getw, putw, puts
extern	overflow

; Lê dois números inteiros e imprime o resultado da exponenciação do primeiro pelo segundo.

%define number1 word [EBP-2]
exp_16:
	enter	2, 0
	call	getw
	mov		number1, ax
	call	getw

	cmp 	ax, 0
	jl 		ltz0

	mov 	cx, ax
	mov 	ax, 1
  ls0:
    test cx, cx
    jz   le0
    imul number1
    jo	 overflow_loop
    dec  cx
    jmp  ls0

  ltz0:
    mov 	ax, 0
  le0:
    push	ax
    call	putw
    leave
    ret

  overflow_loop:
    push	overflow
    call	puts
    mov		eax, 1
    mov		ebx, 1
    int		0x80