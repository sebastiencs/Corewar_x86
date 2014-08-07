;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: load_arena.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 00:59:27 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: malloc', 10, 0

section .text

extern malloc
extern my_putstr
extern init_arena
extern load_champions_in_arena

proc	load_arena, core

	pushx	edx

	mov	eax, [core]

	mov	dword [eax + s_corewar.nbr_live_cur], 0
	mov	dword [eax + s_corewar.cycle_to_die_cur], CYCLE_TO_DIE

	invoke	malloc, MEM_SIZE
	_check_	.FAILM, 0

	mov	edx, [core]
	mov	[edx + s_corewar.arena], eax

	invoke	malloc, MEM_SIZE
	_check_	.FAILM, 0

	mov	edx, [core]
	mov	[edx + s_corewar.info_arena], eax

	invoke	init_arena, [edx + s_corewar.arena], MEM_SIZE, 0
	invoke	init_arena, [edx + s_corewar.info_arena], MEM_SIZE, 0

	invoke	load_champions_in_arena, [edx + s_corewar.arena], [edx + s_corewar.info_arena], edx
	_check_	.FAIL, -1

	xor	eax, eax

.END	popx	edx
	RET

.FAILM	invoke	my_putstr, str1

.FAIL	mov	eax, -1
	jmp	.END

endproc
