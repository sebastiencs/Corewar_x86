;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_i_to_someone.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 17:36:40 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	attribute_i_to_someone, list_champions, i

	_var_	is_already_attr

	pushx	edx

	mov	dword [is_already_attr], 0x0
	mov	eax, [list_champions]

	WHILE	eax, ne, 0x0

		mov	edx, [i]

		IF	dword [eax + s_champions.prog_number], e, edx

			mov	dword [is_already_attr], 0x1

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	IF	dword [is_already_attr], e, 0x1

		jmp	.END

	ENDIF

	mov	eax, [list_champions]

	WHILE	eax, ne, 0x0

		IF	dword [eax + s_champions.prog_number], e, 0x0

			mov	edx, [i]
			mov	dword [eax + s_champions.prog_number], edx
			jmp	.END

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

.END	popx	edx
	xor	eax, eax

endproc
