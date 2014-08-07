;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: save_args.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 01:49:11 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern save_champion
extern is_file_dot_cor

proc	save_args, argc, argv, core

	_var_	nb_cor

	pushx	ecx, edx

	mov	ecx, 1
	mov	dword [nb_cor], 0

	WHILE	ecx, l, [argc]

		mov	eax, [argv]
		invoke	is_file_dot_cor, [eax + (ecx * 4)]

		IF	eax, e, 1

			inc	dword [nb_cor]

			invoke	save_champion, ecx, [argv], [core]
			_check_	.FAIL, -1

		ENDIF

		inc	ecx

	END_WHILE

	mov	eax, [core]
	mov	edx, [nb_cor]
	mov	[eax + s_corewar.nb_champions], edx

	xor	eax, eax

.END	popx	ecx, edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc
