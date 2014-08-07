;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: is_already_define.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 01:41:36 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	is_addr_already_define, champions

	pushx	edx

	xor	edx, edx
	mov	eax, [champions]

	WHILE	eax, ne, 0

		IF	dword [eax + s_champions.load_address], ne, 0

			inc	edx

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	mov	eax, edx
	popx	edx

endproc
