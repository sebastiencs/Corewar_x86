;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: is_good_register.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 23:12:16 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


%include "corewar.inc"

section .text

proc	is_good_register, nb

	xor	eax, eax

	cmp	dword [nb], REG_NUMBER
	jg	.endproc

	cmp	dword [nb], 0
	jle	.endproc

	mov	eax, 1

endproc