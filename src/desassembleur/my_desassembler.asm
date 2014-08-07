;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_desassembler.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 18:44:49 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db '.name', 9, 9, '"', 0
str2:	db '.comment', 9, '"', 0
str3:	db '"', 10, 0
str4:	db 10, 0

inst:
istruc s_instruction
       times 18	db 0
iend

section .text

extern	my_putstr
extern	get_instruction
extern	my_putchar
extern	print_instruction

proc	my_desassembler, core, champions

	_var_	pc_base, instruction

	pushx	eax, ebx, edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	mov	[pc_base], eax

	mov	eax, [champions]

	IF	dword [eax + s_champions.name], ne, 0

		invoke	my_putstr, str1
		invoke	my_putstr, [eax + s_champions.name]
		invoke	my_putstr, str3

	ENDIF

	IF	dword [eax + s_champions.comment], ne, 0

		invoke	my_putstr, str2
		invoke	my_putstr, [eax + s_champions.comment]
		invoke	my_putstr, str3

	ENDIF

	mov	edx, [pc_base]
	add	edx, [eax + s_champions.size]

	WHILE	dword [eax + s_champions.pc], l, edx

		lea	ebx, [inst]
		invoke	get_instruction, [core], [champions], ebx
		lea	ebx, [inst]
		invoke	print_instruction, ebx
		invoke	my_putchar, 10

	END_WHILE

	xor	eax, eax

	popx	eax, ebx, edx

endproc
