SECTION .text
global	sub_32

extern  getdw, putdw

; Lê dois números inteiros e subtrai o segundo do primeiro
%define number1 dword [EBP-4]
sub_32:
	enter 4, 0
  push ebx

	call	getdw
	mov		number1, eax
	call	getdw
	sub		number1, eax
	push	number1
	call	putdw

  push ebx
	leave
	ret