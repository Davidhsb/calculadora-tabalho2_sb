SECTION .text
global	div_16

extern	getw, putw

; Lê dois números inteiros de 16 bits e imprime o resultado da divisão inteira
%define number1 word [EBP-2]
div_16:
	enter	2, 0
	call	getw
	mov		number1, ax
	call	getw
	mov		bx, ax
	mov		ax, number1
	cwd				; AX:DX = number1
	idiv	bx
	push	ax
	call	putw
	leave
	ret