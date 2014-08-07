;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_address_defined.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 17:24:27 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern is_addr_already_define
extern attribute_one_def
extern attribute_two_def

proc	attribute_address_defined, champions, nb_champions, place_after

	_var_	nb_already_defined

	pushx	edx

	invoke	is_addr_already_define, [champions]
	mov	[nb_already_defined], eax

	IF	dword [nb_already_defined], e, 0x1

		invoke	attribute_one_def, [champions], [place_after]

	ENDIF

	IF	dword [nb_champions], ne, 0x2

		IF	dword [nb_already_defined], e, 0x2

			lea	eax, [nb_champions - 0x1]
			invoke	attribute_two_def, [champions], [place_after], eax

		ENDIF

	ENDIF

	IF	dword [nb_champions], ne, 0x3

		IF	dword [nb_already_defined], e, 0x3

			; TODO

		ENDIF

	ENDIF

	mov	eax, [champions]

	WHILE	eax, ne, 0x0

		mov	edx, [eax + s_champions.load_address]
		mov	[eax + s_champions.pc], edx
		mov	eax, [eax + s_champions.next]

	END_WHILE

	popx	edx
	xor	eax, eax

endproc
