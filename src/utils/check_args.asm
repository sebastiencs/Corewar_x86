;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: check_args.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 23:52:21 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db '-dump', 0
str2:	db '-n', 0
str3:	db '-a', 0
str4:	db '-d', 0
str5:	db '.cor', 0

section .text

extern	my_strcmp
extern	my_strlen

proc	is_numbers, string_numbers

	pushx	edx

	cmp	dword [string_numbers], 0
	je	.FAIL

	mov	edx, [string_numbers]

	WHILE	byte [edx], ne, 0

		IF	byte [edx], l, '0'

			jmp	.FAIL

		ENDIF

		IF	byte [edx], g, '9'

			jmp	.FAIL

		ENDIF

		inc	edx

	END_WHILE

	xor	eax, eax

.END	popx	edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc

proc	is_options, string_options

	invoke	my_strcmp, [string_options], str1
	test	eax, eax
	jz	.OK

	invoke	my_strcmp, [string_options], str2
	test	eax, eax
	jz	.OK

	invoke	my_strcmp, [string_options], str3
	test	eax, eax
	jz	.OK

	invoke	my_strcmp, [string_options], str4
	test	eax, eax
	jz	.OK

	xor	eax, eax
	RET

.OK	mov	eax, 1

endproc

proc	is_file_dot_cor, string_file

	invoke	my_strlen, [string_file]
	_check_	.FAIL, 5, l

	sub	eax, 4
	add	eax, [string_file]

	invoke	my_strcmp, eax, str5
	_check_	.FAIL, 0, ne

	mov	eax, 1
	RET

.FAIL	mov	eax, -1

endproc

proc	is_one_file_cor, argc, argv

	_var_	nb_cor

	pushx	ecx

	mov	ecx, 1
	mov	dword [nb_cor], 0

	WHILE	ecx, l, [argc]

		mov	eax, [argv]
		invoke	is_file_dot_cor, [eax + (ecx * 4)]

		IF	eax, e, 1

			inc	dword [nb_cor]

		ENDIF

		inc	ecx

	END_WHILE

	xor	eax, eax

	IF	dword [nb_cor], le, 0

		mov	eax, -1

	ENDIF

	popx	ecx

endproc
