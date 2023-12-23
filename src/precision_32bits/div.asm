SECTION .text
global	div_32

extern	getdw, putdw


; Lê dois números inteiros de 32 bits e imprime o resultado da divisão inteira
%define number1 dword [EBP-4]
div_32:
	enter 4, 0
	call	getdw
	mov		number1, eax
	call	getdw
	mov		ebx, eax
	mov		eax, number1
	cdq		; edx:eax = number1
	idiv	ebx
	push	eax
	call	putdw
	leave
	ret