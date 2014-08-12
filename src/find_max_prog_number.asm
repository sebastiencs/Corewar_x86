;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: find_max_prog_number.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 23:51:59 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	find_max_prog_number, champions

	pushx	edx

	mov	eax, [champions]
	xor	edx, edx

	WHILE	eax, ne, 0

		cmp	[eax + s_champions.prog_number], edx
		cmovg	edx, [eax + s_champions.prog_number]	; bien cette instruction

		mov	eax, [eax + s_champions.next]

	END_WHILE

	mov	eax, edx
	popx	edx

endproc
