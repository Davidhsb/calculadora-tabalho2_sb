SECTION .text
global	mul_32

extern	getdw, putdw, puts
extern	overflow, len_overflow

; Lê dois números de 32 bits e imprime o resultado da multiplicação
%define number1 dword [EBP-4]
mul_32:
	enter 4, 0
	call	getdw
	mov		number1, eax
	call	getdw
	imul	number1
	jo		overflow_loop
	push	eax
	call	putdw
	leave
	ret

  overflow_loop:
    push	overflow
    push  len_overflow
    call	puts
    mov		eax, 1
    mov		ebx, 1
    int		0x80