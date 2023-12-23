SECTION .text
global	sum_16

extern	getw, putw

; Lê dois números e imprime a soma deles.
%define number1 word [EBP-2]
sum_16:
	enter	2, 0
	call	getw
	mov		number1, ax
	call	getw
	add		ax, number1
	push	ax
	call	putw
	leave
	ret
