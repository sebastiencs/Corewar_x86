;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_address.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 17:10:02 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern is_addr_already_define
extern attribute_address_defined

proc	attribute_address, champions, nb_champions

	_var_	place_after

	pushx	edx

	mov	eax, MEM_SIZE
	cdq
	idiv	dword [nb_champions]
	mov	[place_after], eax

	invoke	is_addr_already_define, [champions]

	IF	eax, e, 0x0

		mov	eax, [champions]
		xor	edx, edx

		WHILE	eax, ne, 0x0

			mov	[eax + s_champions.load_address], edx
			mov	[eax + s_champions.pc], edx

			add	edx, dword [place_after]
			mov	eax, [eax + s_champions.next]

		END_WHILE

	ELSE

		invoke	attribute_address_defined, [champions], [nb_champions], [place_after]

	ENDIF

	popx	edx
	xor	eax, eax

endproc
