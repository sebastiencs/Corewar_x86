;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_putnbr.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 18:19:44 (+08:00 UTC)
;;  Updated:   6/08/2014 19:56:58 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	my_putchar, caracter

	pushx	eax, ebx, ecx, edx

	mov	eax, 4
	mov	ebx, 1
	lea	ecx, [caracter]
	mov	edx, 1
	int	80h

	popx	eax, ebx, ecx, edx

endproc

proc	my_putnbr, nb

	pushx	eax, ebx, edx

	IF	dword [nb], l, 0

		invoke	my_putchar, '-'
		mov	eax, [nb]
		mov	edx, -1
		imul	edx
		mov	[nb], eax

	ENDIF

	mov	ebx, 10

	IF	dword [nb], ge, 10

		mov	eax, [nb]
		cdq
		idiv	ebx
		invoke	my_putnbr, eax

	ENDIF

	mov	eax, [nb]
	cdq
	idiv	ebx
	add	edx, '0'
	invoke	my_putchar, edx

	popx	eax, ebx, edx

endproc