;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_first_in_list.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 19:11:22 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern free

proc	check_first_in_list, core, cycle_to_die_cur

	_var_	tmp

	pushx	edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]
	mov	[tmp], eax

.LOOP	cmp	dword [tmp], 0
	je	.ENDL

	mov	eax, [tmp]
	mov	edx, [cycle_to_die_cur]
	cmp	dword [eax + s_champions.last_live], edx
	jl	.ENDL

	mov	eax, [eax + s_champions.next]
	mov	edx, [core]
	mov	dword [edx + s_corewar.champions], eax

	mov	eax, [tmp]
	invoke	free, [eax + s_champions.reg]
	invoke	free, eax

	mov	eax, [core]
	dec	dword [eax + s_corewar.nb_champions]

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]
	mov	[tmp], eax
	jmp	.LOOP

.ENDL	popx	edx

endproc