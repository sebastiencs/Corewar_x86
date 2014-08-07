;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: save_champion.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 02:01:34 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:		db '-n', 0
str2:		db '-a', 0
mem_size:	dd MEM_SIZE

section .text

extern push_champion
extern is_file_dot_cor
extern my_strcmp
extern atoi

proc	save_champion, i, argv, core

	_var_	cur, prog_number, load_address

	pushx	ecx, edx

	mov	ecx, [i]
	mov	[cur], ecx
	dec	ecx
	mov	dword [prog_number], 0
	mov	dword [load_address], 0

	WHILE	ecx, g, 0

		mov	eax, [argv]
		invoke	is_file_dot_cor, [eax + (ecx * 4)]
		_check_	.ENDL, -1

		mov	eax, [argv]
		invoke	my_strcmp, [eax + (ecx * 4)], str1

		IF	eax, e, 0

			invoke	atoi, [eax + (ecx * 4) + 4]
			mov	[prog_number], eax

		ENDIF

		mov	eax, [argv]
		invoke	my_strcmp, [eax + (ecx * 4)], str2

		IF	eax, e, 0

			invoke	atoi, [eax + (ecx * 4) + 4]
			cdq
			idiv	dword [mem_size]
			mov	[load_address], edx

		ENDIF

		dec	ecx

	END_WHILE

.ENDL	mov	eax, [argv]
	mov	edx, [cur]
	invoke	push_champion, [core], [eax + (edx * 4)], [prog_number], [load_address]
	_check_	.FAIL, -1

	xor	eax, eax

.END	popx	ecx, edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc
