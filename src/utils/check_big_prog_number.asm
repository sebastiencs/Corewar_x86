;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_big_prog_number.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 00:22:33 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: prog_number too big !', 10, 0

section .text

extern my_putstr

proc	check_big_prog_number, list_champion, nb_champions

	pushx	edx

	mov	eax, [list_champion]
	mov	edx, [nb_champions]

	WHILE	eax, ne, 0

		IF	[eax + s_champions.prog_number], g, edx

			jmp	.FAIL

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	xor	eax, eax
.END	popx	edx
	RET

.FAIL	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.END

endproc
