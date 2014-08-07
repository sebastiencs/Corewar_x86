;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: search_who_still_alive.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 18:37:52 (+08:00 UTC)
;;  Updated:  19/07/2014 19:11:08 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern winner

proc	search_who_still_alive, core

	_var_	id_champion

	pushx	edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]
	mov	dword [id_champion], 0

.LOOP	cmp	eax, 0
	je	.ENDL

	mov	edx, [eax + s_champions.color_gui]

	cmp	dword [id_champion], 0
	je	.ELSE

	cmp	dword [id_champion], edx
	je	.ELSE

	mov	eax, 1
	jmp	.ENDPROC

.ELSE	mov	[id_champion], edx

	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ENDL	invoke	winner, [core]
	popx	edx
	xor	eax, eax

endproc