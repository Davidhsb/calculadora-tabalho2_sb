SECTION .text
global	mod_32

extern	getdw, putdw

; Lê dois números inteiros de 32 bits e retorna o resto da divisão do primeiro pelo segundo.
%define number1 dword [EBP-4]
mod_32:
	enter 4, 0
	call	getdw
	mov		number1, eax
	call	getdw
	mov		ebx, eax
	mov		eax, number1
	cdq		; edx:eax = number1
	idiv	ebx
	push	edx ; resto da divisão
	call	putdw
	leave
	ret