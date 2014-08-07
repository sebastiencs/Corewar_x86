;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: print_instruction.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 18:04:49 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

op_code:	dd 1, 2, 3, 4, 5,6 ,7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 0

live:		db 'live', 0
ld:		db 'ld', 0
l_st:		db 'st', 0
l_add:		db 'add', 0
l_sub:		db 'sub', 0
l_and:		db 'and', 0
l_or:		db 'or', 0
l_xor:		db 'xor', 0
zjmp:		db 'zjmp', 0
ldi:		db 'ldi', 0
l_sti:		db 'sti', 0
fork:		db 'fork', 0
lld:		db 'lld', 0
lldi:		db 'lldi', 0
lfork:		db 'lfork', 0
aff:		db 'aff', 0

op_memn_tab:	dd live, ld, l_st, l_add, l_sub, l_and, l_or, l_xor, zjmp, ldi, l_sti, fork, lld, lldi, lfork, aff

section .text

extern my_putstr
extern my_putchar
extern print_args
extern my_putnbr

proc	print_instruction, instruction

	_var_	tmp_type

	pushx	eax, ecx, edx

	xor	ecx, ecx
	mov	eax, [instruction]
	movzx	eax, byte [eax + s_instruction.type]
	shr	eax, 2
	shl	eax, 2
	mov	[tmp_type], eax

	mov	eax, op_code
	mov	edx, [instruction]
	movzx	edx, byte [edx + s_instruction.code]

	WHILE	dword [eax + (ecx * 4)], ne, 0

		cmp	[eax + (ecx * 4)], edx
		jz	.OK

		inc	ecx

	END_WHILE

.OK	IF	dword [eax + (ecx * 4)], ne, 0

		mov	edx, op_memn_tab
		mov	edx, [edx + (ecx * 4)]

		invoke	my_putstr, edx
		invoke	my_putchar, 9	; \t

		mov	edx, [instruction]
		movzx	edx, byte [edx + s_instruction.code]

		cmp	dl, LIVE
		jz	.DO

		cmp	dl, ZJMP
		jz	.DO

		cmp	dl, FORK
		jz	.DO

		cmp	dl, LFORK
		jz	.DO

		jmp	.NO


.DO		IF	dl, e, LIVE

			invoke	my_putchar, DIRECT_CHAR

		ENDIF

		mov	edx, [instruction]
		mov	edx, [edx + s_instruction.params]

		invoke	my_putnbr, edx

.NO		xor	ecx, ecx

.LOOP		mov	eax, [tmp_type]
		and	al, 0b11000000
		cmp	al, 0
		jz	.ENDL

		lea	eax, [tmp_type]
		invoke	print_args, eax, [instruction], ecx

		inc	ecx
		jmp	.LOOP

	ENDIF

.ENDL	popx	eax, ecx, edx

endproc