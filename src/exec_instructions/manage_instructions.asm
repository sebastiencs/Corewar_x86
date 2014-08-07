;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: manage_instructions.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 12:46:57 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

i:			dd	0
cycle_to_die_cur:	dd	0
str1:			db 'i = %d', 10, 0

section .text

extern check_live_process
extern exec_instructions

proc	manage_instructions, core

	pushx	edx


	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, [i]
	; popx	eax, ebx, ecx, edx


	IF	dword [i], e, 0

		mov	dword [i], 1

	ENDIF

	IF	dword [cycle_to_die_cur], e, 0

		mov	dword [cycle_to_die_cur], CYCLE_TO_DIE

	ENDIF

	mov	eax, [i]
	IF	eax, ge, [cycle_to_die_cur]

		invoke	check_live_process, [core], [cycle_to_die_cur]
		_check_	.ONE, 1
		mov	dword [i], 1

	ENDIF

	mov	eax, [core]
	IF	dword [eax + s_corewar.nbr_live_cur] , ge, NBR_LIVE

		sub	dword [cycle_to_die_cur], CYCLE_DELTA
		mov	edx, [cycle_to_die_cur]
		mov	dword [eax + s_corewar.cycle_to_die_cur], edx
		mov	dword [eax + s_corewar.nbr_live_cur], 0

	ENDIF

	inc	dword [i]

	mov	eax, [core]
	mov	eax, [eax + s_corewar.champions]
	invoke	exec_instructions, [core], eax
	_check_	.FAIL, -1

	xor	eax, eax
	jmp	.END

.ONE	mov	eax, 1
	jmp	.END

.FAIL	mov	eax, -1

.END	popx	edx

endproc