;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_arena.asm
;;  Author:   chapui_s
;;  Created:  16/07/2014 22:09:30 (+08:00 UTC)
;;  Updated:  26/07/2014 15:02:11 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'j = %d\n', 10, 0

section .text

extern disp_arena
extern disp_gui
extern manage_instructions
extern manage_event
extern my_showmem

extern printf

proc	get_arena, core, gui

	_var_	_pause, j

	mov	dword [j], 0
	mov	dword [_pause], 0

.LOOP	mov	eax, [j]
	cmp	eax, 100000
	jge	.ENDPROC

	lea	eax, [_pause]
	invoke	manage_event, [core], [gui], eax
	_check_	.END, -1

	IF	dword [_pause], e, 0

		invoke	manage_instructions, [core]
		_check_	.END, 1

		invoke	disp_arena, [core], [gui], [j], 0
		_check_	.FAIL, -1

		inc	dword [j]

	ELSE

		invoke	disp_arena, [core], [gui], [j], 1

	ENDIF

	mov	eax, [core]
	mov	eax, [eax + s_corewar.nbr_cycle_dump]
	IF	[j], e, eax

		mov  eax, [core]
		invoke	my_showmem, [eax + s_corewar.arena], MEM_SIZE
		jmp	.endproc

	ENDIF

	jmp	.LOOP

.END	xor	eax, eax
	jmp	.endproc

.FAIL	mov	eax, -1

endproc
