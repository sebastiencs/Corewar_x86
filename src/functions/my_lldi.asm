;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_lldi.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 22:14:37 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern get_first_value
extern get_second_value
extern read_arena
extern is_register
extern is_good_register

proc	my_lldi, core, champions, instruction

	_var_	first_value, read_value, pc, param2, reg_ptr

	pushx	edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.reg]
	mov	dword [reg_ptr], eax

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	mov	dword [pc], eax

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 0x8]
	mov	dword [param2], eax

	invoke	get_first_value, [core], [champions], [instruction], 0x1
	mov	dword [first_value], eax

	invoke	get_second_value, [core], [champions], [instruction]

	add	eax, [first_value]
	add	eax, [pc]
	sub	eax, 0x6

	invoke	read_arena, [core], eax, 0x4
	mov	dword [read_value], eax

	mov	eax, [instruction]
	movzx	eax, byte [eax + s_instruction.type]
	invoke	is_register, eax, 0x3
	cmp	eax, 0x1
	jne	.END

	invoke	is_good_register, [param2]
	cmp	eax, 0x1
	jne	.END

	mov	eax, dword [param2]
	shl	eax, 0x2
	add	eax, dword [reg_ptr]

	mov	edx, [read_value]
	mov	[eax], edx

	cmp	edx, 0
	je	.ONE

	xor	edx, edx
	jmp	.CARRY

.ONE	mov	edx, 1

.CARRY	mov	eax, [champions]
	lea	eax, [eax + s_champions.carry]
	mov	[eax], edx

.END	xor	eax, eax
	popx	edx

endproc