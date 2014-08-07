;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_dump.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 00:05:09 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db '-dump', 0
str2:	db '-d', 0

section .text

extern my_strcmp
extern my_putstr

proc	get_dump, argc, argv, core

	pushx	eax, ecx, edx

	mov	ecx, 1
	mov	eax, [core]
	mov	dword [eax + s_corewar.nbr_cycle_dump], 0
	mov	dword [eax + s_corewar.is_desassembler], 0

	WHILE	ecx, l, [argc]

		mov	eax, [argv]
		invoke	my_strcmp, [eax + (ecx * 4)], str1

		IF	eax, e, 0

			push	ecx

			mov	eax, [argv]
			invoke	atoi, [eax + (ecx * 4) + 4]
			mov	edx, [core]
			mov	[edx + s_corewar.nbr_cycle_dump], eax

			pop	ecx

		ENDIF

		mov	eax, [argv]
		invoke	my_strcmp, [eax + (ecx * 4)], str2

		IF	eax, e, 0

			mov	eax, [core]
			mov	dword [eax + s_corewar.is_desassembler], 1

		ENDIF

		inc	ecx

	END_WHILE

	popx	eax, ecx, edx

endproc
