;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_same_prog_number.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 00:37:39 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: two programs have the same number', 10, 0

section .text

extern my_putstr

proc	check_same_prog_number, list_champion

	_var_	prog_number

	pushx	ebx, edx

	mov	eax, [list_champion]

	WHILE	eax, ne, 0

		mov	edx, [eax + s_champions.prog_number]
		mov	[prog_number], edx

		mov	ebx, [eax + s_champions.next]

		WHILE	ebx, ne, 0

			mov	edx, [ebx + s_champions.prog_number]

			IF	[prog_number], e, edx

				IF	dword [prog_number], ne, 0

					jmp	.FAIL

				ENDIF

			ENDIF

			mov	ebx, [ebx + s_champions.next]

		END_WHILE

		mov	eax, [eax + s_champions.next]

	END_WHILE

	xor	eax, eax
.END	popx	ebx, edx
	RET

.FAIL	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.END

endproc
