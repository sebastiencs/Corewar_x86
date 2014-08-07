;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_live_process.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 19:26:44 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern check_first_in_list
extern free
extern search_who_still_alive

proc	check_live_process, core, cycle_to_die_cur

	_var_	tmp, tmp_to_rm

	pushx	edx

	invoke	check_first_in_list, [core], [cycle_to_die_cur]

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]
	mov	[tmp], eax

.LOOP	cmp	dword [tmp], 0
	je	.ENDL

	mov	edx, [cycle_to_die_cur]

	mov	eax, [tmp]
	mov	eax, [eax + s_champions.next]
	cmp	eax, 0
	je	.ELSE

	cmp	dword [eax + s_champions.last_live], edx
	jl	.ELSE

	mov	[tmp_to_rm], eax
	mov	eax, [eax + s_champions.next]
	mov	edx, [tmp]
	mov	[edx + s_champions.next], eax

	cmp	dword [edx + s_champions.next], 0
	jne	.NOT

	mov	eax, [core]
	mov	dword [eax + s_corewar.last_champions], edx

.NOT	mov	eax, [tmp_to_rm]

	mov	eax, [core]
	dec	dword [eax + s_corewar.nb_champions]
	jmp	.LOOP

.ELSE	mov	eax, [tmp]
	mov	eax, [eax + s_champions.next]
	mov	[tmp], eax
	jmp	.LOOP

.ENDL	invoke	search_who_still_alive, [core]
	cmp	eax, 0
	je	.ONE

	xor	eax, eax
	jmp	.END

.ONE	mov	eax, 1

.END	popx	edx

endproc