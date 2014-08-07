;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: desassemble_it.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 18:52:49 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 9, '[', 0
str2:	db ']', 10, 0

section .text

extern	my_putstr
extern	my_desassembler

proc	desassemble_it, core

	_var_	is_filename

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]

	mov	dword [is_filename], 0

	IF	dword [eax + s_champions.next], ne, 0

		mov	dword [is_filename], 1

	ENDIF

	WHILE	eax, ne, 0

		IF	dword [is_filename], e, 1

			invoke	my_putstr, str1
			invoke	my_putstr, [eax + s_champions.filename]
			invoke	my_putstr, str2

		ENDIF

		invoke	my_desassembler, [core], eax

		mov	eax, [eax + s_champions.next]

	END_WHILE

	xor	eax, eax

endproc