SECTION .text
global	mul_16

extern	getw, putw, puts
extern	overflow, len_overflow

; Lê dois números de 16 bits e imprime o resultado da multiplicação
%define number1 word [EBP-2]
mul_16:
	enter	2, 0
	call	getw
	mov		number1, ax
	call	getw
	imul	number1
	jo		overflow_loop
	push	ax
	call	putw
	leave
	ret

  overflow_loop:
    push	overflow
    push  len_overflow
    call	puts
    mov		eax, 1
    mov		ebx, 1
    int		0x80
