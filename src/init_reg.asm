;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: init_reg.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 00:09:28 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	init_reg, reg, prog_number

	pushx	eax, ecx, edx

	mov	ecx, 2
	mov	eax, [reg]
	mov	edx, [prog_number]
	mov	[eax + 4], edx

	WHILE	ecx, le, REG_NUMBER

		mov	dword [eax + (ecx * 4)], 0
		inc	ecx

	END_WHILE

	popx	eax, ecx, edx

endproc
