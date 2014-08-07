;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: main.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 01:48:15 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

t_corewar:
istruc s_corewar
    at s_corewar.arena,			dd	0
    at s_corewar.info_arena,		dd	0
    at s_corewar.nb_champions,		dd	0
    at s_corewar.champions,		dd	0
    at s_corewar.last_champions,	dd	0
    at s_corewar.last_live_nb,		dd	0
    at s_corewar.last_live_name,	dd	0
    at s_corewar.prog_number_max,	dd	0
    at s_corewar.nbr_cycle_dump,	dd	0
    at s_corewar.nbr_live_cur,		dd	0
    at s_corewar.is_desassembler,	dd	0
    at s_corewar.cycle_to_die_cur,	dd	0
iend

global	mem_size
global	idx_mod

mem_size:	dd	MEM_SIZE
idx_mod:	dd	IDX_MOD

section .text

extern get_args
extern load_arena
extern my_gui
extern desassemble_it

proc	main, argc, argv

	invoke	get_args, [argc], [argv], t_corewar
	_check_	.FAIL, -1

	invoke	load_arena, t_corewar
	_check_	.FAIL, -1

	IF	dword [t_corewar + s_corewar.is_desassembler], e, 1

		invoke	desassemble_it, t_corewar

	ELSE

		mov	eax, [argv]
		invoke	my_gui, t_corewar, [eax]
		_check_	.FAIL, -1

	ENDIF

	xor	eax, eax
	RET

.FAIL	mov	eax, -1

endproc
