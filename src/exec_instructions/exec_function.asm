;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: exec_function.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 11:15:20 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

extern my_live
extern my_ld
extern my_st
extern my_add
extern my_sub
extern my_and
extern my_or
extern my_xor
extern my_zjmp
extern my_ldi
extern my_sti
extern my_fork
extern my_lld
extern my_lldi
extern my_lfork

extern disp_carry

section .data

t_functions:
	dd	0x01, my_live,	\
		0x02, my_ld,	\
		0x03, my_st,	\
		0x04, my_add,	\
		0x05, my_sub,	\
		0x06, my_and,	\
		0x07, my_or,	\
		0x08, my_xor,	\
		0x09, my_zjmp,	\
		0x0A, my_ldi,	\
		0x0B, my_sti,	\
		0x0C, my_fork,	\
		0x0D, my_lld,	\
		0x0E, my_lldi,	\
		0x0F, my_lfork,	\
		0x10, 0x0

section .text

proc	exec_function, core, champions, instruction

	; pushx	eax, ebx, ecx, edx
	; invoke	disp_carry, [champions]
	; popx	eax, ebx, ecx, edx

	mov	eax, [instruction]
	movzx	eax, byte [eax + s_instruction.code]

	cmp	eax, REG_NUMBER
	jg	.END

	cmp	eax, 0
	jle	.END

	dec	eax
	shl	eax, 3
	add	eax, t_functions
	add	eax, 4

	invoke	[eax], [core], [champions], [instruction]
	_check_	.FAIL, -1

.END	xor	eax, eax
	jmp	.endproc

.FAIL	mov	eax, -1

endproc
