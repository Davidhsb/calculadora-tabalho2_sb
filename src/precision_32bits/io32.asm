SECTION .bss
local resb 13	

SECTION .text
global	puts, putdw, gets, getdw, strlen

; Recebe um ponteiro para uma string e imprime a string na tela
puts:
  enter 0, 0

  push eax
  push ebx
  push ecx
  push edx

  mov eax, 4
  mov ebx, 1
  mov ecx, [ebp + 12]
  mov edx, [ebp + 8]
  int 80h
  
  pop edx
  pop ecx
  pop ebx
  pop eax
  
  leave
  ret 8

; Retorna o tamanho da string
strlen:
	enter 0, 0
	mov eax, [EBP+8]

  strlen_loop:
    cmp byte [eax], 0
    jz  strlen_end
    inc eax
    jmp strlen_loop

  strlen_end:
    sub eax, [EBP+8]

    leave
    ret 4

; Recebe um inteiro e imprime na tela
%define num_str dword [EBP-4]
putdw:
	enter	4, 0

  push eax
  push ebx
  push ecx
  push edx

	mov		num_str, local
	
	mov		eax, [EBP+8]
	xor		ecx, ecx
	mov		ebx, num_str
	mov		esi, 10
	cmp		eax , 0
	jge		putdw_loop1
	mov byte [ebx], '-'
	inc		ebx
	neg		eax

  putdw_loop1:
    cdq
    idiv	esi
    add		edx, 0x30
    push	edx
    inc		ecx
    cmp		eax, 0
    je		putdw_nt
    jmp		putdw_loop1

  putdw_nt:
    mov word [ebx+ecx], 0x000A

  putdw_loop2:
    pop		edx
    mov		[ebx], dl
    inc		ebx
    dec		ecx
    jnz		putdw_loop2

    push	num_str
    call  strlen
    push  num_str
    push  eax
    call	puts

    pop edx
    pop ecx
    pop ebx
    pop eax

    leave
    ret 4

; Lê a string e armazena no ponteiro passado
gets:
	enter	0, 0
  
  push ebx
  push ecx
  push edx

	mov	eax, 3
	mov	ebx, 0
	mov	ecx, [EBP+8]
	mov	edx, [EBP+12]
	int	0x80

	mov		ebx, [EBP+8]
	mov byte [ebx+eax-1], 0

  pop edx
  pop ecx
  pop ebx

	leave
	ret	8

; Lê a string e converte para inteiro

%define num_str dword [EBP-4]
%define negative word [EBP-6]
getdw:
	enter	6, 0

  push ebx
  push ecx
  push edx

	mov		num_str, local

	push dword 12
	push 	num_str
	call	gets

	xor		eax, eax
	xor		ecx, ecx
	xor		dx, dx
	mov		ebx, num_str
	cmp byte [ebx], '-'	; Confore se é negativo
	sete	dl
	mov		negative, dx
	jne		getdw_loop
	inc		ecx
	
  getdw_loop:
    sub byte [ebx+ecx], 0x30
    movsx	edx, byte [ebx+ecx]
    add		eax, edx

    cmp byte [ebx+ecx+1], 0
    je		getdw_l_end
    mov		edx, eax
    sal		eax, 2
    add		eax, edx
    add		eax, eax		;eax = eax*10
    inc		ecx
    jmp		getdw_loop

  getdw_l_end:
    cmp		negative, 0
    je		getdw_end
    neg		eax
  getdw_end:
    pop edx
    pop ecx
    pop ebx

    leave
    ret