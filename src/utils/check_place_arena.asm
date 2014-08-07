;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_place_arena.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 00:24:09 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .data

str1:	db 'error: two champions are in the same address', 10, 0

section .text

extern my_putstr

proc	check_place_arena, info_arena, prog_number, i

	pushx	edx

	mov	eax, [info_arena]
	mov	edx, [i]
	add	eax, [edx]
	inc	dword [edx]

	IF	byte [eax], e, 0

		mov	edx, [prog_number]
		mov	byte [eax], dl
		xor	eax, eax

	ELSE

		invoke	my_putstr, str1
		mov	eax, -1

	ENDIF

	popx	edx

endproc
