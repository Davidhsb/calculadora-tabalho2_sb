SECTION .text
global	mod_16

extern	getw, putw

; Lê dois números inteiros e imprime o resto da divisão do primeiro pelo segundo.
%define number1 word [EBP-2]
mod_16:
	enter	2, 0
	call	getw
	mov		number1, ax
	call	getw
	mov		bx, ax
	mov		ax, number1
	cwd		; ax:dx = number1
	idiv	bx
	push	dx ; resto da divisão
	call	putw
	leave
	ret