SECTION .text
global	sub_16

extern	getw, putw

; Lê dois números inteiros e subtrai o segundo do primeiro.
%define number1 word [EBP-2]
sub_16:
	enter	2, 0
  push  bx

	call	getw
	mov		number1, ax
	call	getw
	sub		number1, ax
	push	number1
	call	putw

  push  bx
	leave
	ret