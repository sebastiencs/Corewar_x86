;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: list_champions.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 00:52:34 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str_malloc_error:	db MALLOC_FAILED

section .text

extern my_putstr
extern malloc

proc	create_champion, file, prog_n, load_a

	pushx	edx

	invoke	malloc, SIZE_S_CHAMPIONS
	_check_	.FAIL, 0

	mov	edx, [file]
	mov	[eax + s_champions.filename], edx

	mov	edx, [prog_n]
	mov	[eax + s_champions.prog_number], edx
	mov	[eax + s_champions.color_gui], edx

	mov	edx, [load_a]
	mov	[eax + s_champions.load_address], edx
	mov	dword [eax + s_champions.next], 0

.END	popx	edx
	RET

.FAIL	invoke	my_putstr, str_malloc_error
	xor	eax, eax
	jmp	.END

endproc

proc	push_champion, core, filename, prog_number, load_address

	pushx	edx

	invoke	create_champion, [filename], [prog_number], [load_address]
	_check_	.FAIL, 0

	mov	edx, eax

	mov	eax, [core]
	mov	[eax + s_corewar.last_champions], edx

	IF	dword [eax + s_corewar.champions], ne, 0

		mov	eax, [eax + s_corewar.champions]

		WHILE	dword [eax + s_champions.next], ne, 0

			mov	eax, [eax + s_champions.next]

		END_WHILE

		lea	eax, [eax + s_champions.next]

	ELSE

		lea	eax, [eax + s_corewar.champions]

	ENDIF

	mov	[eax], edx

	xor	eax, eax

.END	popx	edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc
