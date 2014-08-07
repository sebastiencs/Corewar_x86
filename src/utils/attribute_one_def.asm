;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_one_def.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 18:16:42 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

extern	mem_size

section .text

proc	attribute_one_def, champions, place_after

	_var_	place_save

	pushx	eax, edx

	mov	dword [place_save], 0x0
	mov	eax, [champions]

	WHILE	eax, ne, 0x0

		mov	edx, [eax + s_champions.load_address]

		IF	edx, ne, 0x0

			mov	dword [place_save], edx

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	mov	eax, [champions]

	WHILE	eax, ne, 0x0

		IF	dword [eax + s_champions.load_address], e, 0x0

			push	eax  	; save pour division

			mov	eax, [place_save]
			add	eax, [place_after]
			cdq
			idiv	dword [mem_size]

			pop	eax	; restore

			mov	[eax + s_champions.load_address], edx
			mov	[place_save], edx

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	popx	eax, edx

endproc
