;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: print_args.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 17:54:56 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'r', 0

section .text

extern my_putstr
extern my_putnbr
extern my_putchar

proc	print_args, tmp_type, instruction, i

	_var_	tmp_int

	pushx	eax, ecx, edx

	mov	eax, [tmp_type]
	mov	eax, [eax]
	mov	[tmp_int], eax
	mov	ecx, [i]

	and	eax, 0b11000000
	shr	eax, 6

	IF	eax, e, 1

		invoke	my_putstr, str1

	ELSEIF	eax, e, 10b

		invoke	my_putchar, DIRECT_CHAR

	ENDIF

	mov	eax, [instruction]
	lea	eax, [eax + s_instruction.params]
	mov	eax, [eax + (ecx * 4)]
	invoke	my_putnbr, eax

	mov	eax, [tmp_int]
	shl	al, 2
	mov	edx, [tmp_type]
	mov	[edx], eax

	and	eax, 0b11000000
	IF	eax, ne, 0

		invoke	my_putchar, SEPARATOR_CHAR

	ENDIF

	popx	eax, ecx, edx

endproc