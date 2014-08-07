;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: arguments.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 22:23:22 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db '-d', 0

section .text

extern strcmp
extern is_options
extern is_numbers
extern is_file_dot_cor
extern is_one_file_cor
extern usage
extern get_dump
extern printf
extern my_strcmp
extern save_args
extern attribute_prog_number
extern attribute_address

proc	is_error_in_args, argc1, argv1

	pushx	ebx, ecx

	IF	dword [argc1], l, 2

		jmp	.FAIL

	ENDIF

	mov	ecx, 1
	mov	ebx, [argv1]

	WHILE	ecx, l, [argc1]

		invoke	is_options, [ebx + (ecx * 4)]

		IF	eax, ne, 0

			invoke	is_numbers, [ebx + ((ecx + 1)* 4)]

			IF	eax, e, -1

				invoke	my_strcmp, [ebx + (ecx * 4)], str1
				test	eax, eax
				jnz	.FAIL

			ENDIF

			add	ecx, 2

		ELSE

			invoke	is_file_dot_cor, [ebx + (ecx * 4)]
			cmp	eax, -1
			je	.FAIL

			inc	ecx

		ENDIF

	END_WHILE

	invoke	is_one_file_cor, [argc1], [argv1]
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax

.END	popx	ebx, ecx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc

proc	get_args, argc, argv, core

	invoke	is_error_in_args, [argc], [argv]

	IF	eax, e, -1

		call	usage
		jmp	.FAIL

	ENDIF

	invoke	get_dump, [argc], [argv], [core]

	invoke	save_args, [argc], [argv], [core]
	_check_	.FAIL, -1

	mov	eax, [core]
	invoke	attribute_prog_number, [eax + s_corewar.champions], [eax + s_corewar.nb_champions]
	_check_	.FAIL, -1

	mov	eax, [core]
	invoke	attribute_address, [eax + s_corewar.champions], [eax + s_corewar.nb_champions]
	_check_	.FAIL, -1

	xor	eax, eax
	RET

.FAIL	mov	eax, -1

endproc
