SECTION .text
global	sum_32

extern  getdw, putdw

; Lê dois números de 32 bits, soma-os e imprime o resultado
%define number1 dword [EBP-4]
sum_32:
	enter 4, 0
	call	getdw
	mov		number1, eax
	call	getdw
	add		eax, number1
	push	eax
	call	putdw
	leave
	ret