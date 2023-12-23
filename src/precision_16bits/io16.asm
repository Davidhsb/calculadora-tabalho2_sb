SECTION .bss
local resb 13

SECTION .text
global	puts, putw, gets, getw, strlen

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
putw:
	enter	4, 0
  push eax
  push ebx
  push ecx
  push edx

	mov		num_str, local
	
	mov		ax, [EBP+8]
	xor		ecx, ecx
	mov		ebx, num_str
	mov		si, 10
	cmp		ax , 0
	jge		putw_loop1
	mov byte [ebx], '-'
	inc		ebx
	neg		ax

  putw_loop1:
    cwd
    idiv	si
    add		dx, 0x30
    push	dx
    inc		ecx
    cmp		ax, 0
    je		putw_nt
    jmp		putw_loop1

  putw_nt:
    mov word [ebx+ecx], 0x000A

  putw_loop2:
    pop		dx
    mov		[ebx], dl
    inc		ebx
    dec		ecx
    jnz		putw_loop2

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
    ret 2

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
getw:
	enter	6, 0

  push ebx
  push ecx
  push edx

	mov num_str, local

	push dword 12
	push  num_str
	call  gets

	xor ax, ax
	xor ecx, ecx
	xor dx, dx
	mov ebx, num_str
	cmp byte [ebx], '-'	; Confere se é negativo
	sete	dl
	mov		negative, dx
	jne		getw_loop
	inc		ecx
	
  getw_loop:
    sub byte [ebx+ecx], 0x30
    add		al, [ebx+ecx]
    adc		ah, 0

    cmp byte [ebx+ecx+1], 0
    je		getw_l_end
    mov		dx, ax
    sal		ax, 2
    add		ax, dx
    add		ax, ax		; ax = ax*10
    inc		ecx
    jmp		getw_loop

  getw_l_end:
    cmp		negative, 0
    je		getw_end
    neg		ax
  getw_end:
    pop edx
    pop ecx
    pop ebx

    leave
    ret
