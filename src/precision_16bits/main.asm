SECTION .data
global	overflow, len_overflow

msg1     db		"Bem vindo. Digite seu username: ", 0
len_msg1 equ	$-msg1
msg2     db 	"Hola, ", 0
len_msg2 equ	$-msg2
msg3     db 	", bem-vindo ao programa de CALC IA-32", 0xA, 0
len_msg3 equ	$-msg3

menu1     db	"ESCOLHA UMA OPÇÃO:", 0xA, 0
len_menu1 equ	$-menu1
menu2     db	"- 1: SOMA", 0xA, 0
len_menu2 equ	$-menu2
menu3     db	"- 2: SUBTRACAO", 0xA, 0
len_menu3 equ	$-menu3
menu4     db	"- 3: MULTIPLICACAO", 0xA, 0
len_menu4 equ	$-menu4
menu5     db	"- 4: DIVISAO", 0xA, 0
len_menu5 equ	$-menu5
menu6     db	"- 5: EXPONENCIACAO", 0xA, 0
len_menu6 equ	$-menu6
menu7     db	"- 6: MOD", 0xA, 0
len_menu7 equ	$-menu7
menu8     db	"- 7: SAIR", 0xA, 0
len_menu8 equ	$-menu8

overflow db	"OCORREU OVERFLOW", 0xA, 0
len_overflow equ	$-overflow

SECTION .bss
operation	resb	2	; Operação escolhida pelo usuário
username resb	101	; Nome do usuário

SECTION .text
global	_start

extern	puts, gets, strlen
extern	sum_16, sub_16, mul_16, div_16, exp_16, mod_16

_start:
	push	msg1
  push  len_msg1
	call	puts

	;ler username do usuário
	push  dword 100
	push	username
	call	gets

	push	msg2
  push  len_msg2
	call	puts

	; Printa username do usuário
	push  username
  call  strlen
  push  username
  push  eax
	call  puts

	push	msg3
  push  len_msg3
	call	puts

  menu:
    push	menu1
    push  len_menu1
    call	puts

    push	menu2
    push  len_menu2
    call	puts

    push	menu3
    push  len_menu3
    call	puts

    push	menu4
    push  len_menu4
    call	puts

    push	menu5
    push  len_menu5
    call	puts

    push	menu6
    push  len_menu6
    call	puts

    push	menu7
    push  len_menu7
    call	puts

    push	menu8
    push  len_menu8
    call	puts

    ;ler opção
    push 2
    push operation
    call gets

    cmp byte [operation], '1'
    je  OptSum
    cmp byte [operation], '2'
    je  OptSub
    cmp byte [operation], '3'
    je  OptMul
    cmp byte [operation], '4'
    je  OptDiv
    cmp byte [operation], '5'
    je  OptExp
    cmp byte [operation], '6'
    je  OptMod

  end:
    mov		eax, 1
    mov		ebx, 0
    int		0x80

  OptSum:
    call	sum_16
    jmp		menu
  OptSub:
    call	sub_16
    jmp		menu
  OptMul:
    call	mul_16
    jmp		menu
  OptDiv:
    call	div_16
    jmp		menu
  OptExp:
    call	exp_16
    jmp		menu
  OptMod:
    call	mod_16
    jmp		menu