;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: load_champions_in_arena.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 01:00:28 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: too many programmes (max = 4)', 10, 0

section .text

extern load_file_in_arena
extern init_values_champions
extern find_max_prog_number
extern my_putstr
extern get_cycle_to_wait

proc	load_champions_in_arena, arena, info_arena, core

	pushx	edx

	mov	eax, [core]
	invoke	load_file_in_arena, [arena], [info_arena], [eax + s_corewar.champions]
	_check_	.FAIL, -1

	mov	eax, [core]
	invoke	init_values_champions, [eax + s_corewar.champions]

	mov	eax, [core]
	invoke	find_max_prog_number, [eax + s_corewar.champions]
	mov	edx, [core]
	mov	[edx + s_corewar.prog_number_max], eax

	mov	eax, [edx + s_corewar.champions]

	WHILE	eax, ne, 0

		invoke	get_cycle_to_wait, [core], eax
		mov	eax, [eax + s_champions.next]

	END_WHILE

	mov	eax, [core]

	cmp	dword [eax + s_corewar.nb_champions], 4
	jg	.FAILN

	xor	eax, eax

.END	popx	edx
	RET

.FAILN	invoke	my_putstr, str1

.FAIL	mov	eax, -1
	jmp	.END

endproc
