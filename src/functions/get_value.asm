;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_value.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 19:44:16 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'GET_VALUE: %d', 10, 0
str2:	db '[REGISTER] ', 0

section .text

extern get_size_param
extern is_direct
extern is_indirect
extern is_register
extern is_good_register
extern read_arena

extern my_putstr
extern my_putnbr

proc	get_value, core, champions, instruction, param

	_var_	value, pc, size_param, other, idx_mod, param_1, mem_size

	pushx	ecx, edx

	mov	dword [idx_mod], IDX_MOD
	mov	dword [mem_size], MEM_SIZE

	mov	eax, [param]
	dec	eax
	shl	eax, 2
	mov	edx, [instruction]
	add	edx, s_instruction.params
	add	eax, edx
	mov	eax, [eax]
	mov	[param_1], eax

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

.IF	invoke	is_register, edx, [param]
	cmp	eax, 1
	jne	.ELSIF1

	invoke	is_good_register, [param_1]
	cmp	eax, 1
	jne	.END

	; invoke	my_putnbr, [param_1]

	mov	eax, [champions]
	mov	eax, [eax + s_champions.reg]
	mov	edx, [param_1]
	shl	edx, 2
	add	eax, edx
	; add	eax, [param_1]

	mov	eax, [eax]
	mov	[value], eax
	jmp	.END

.ELSIF1	invoke	is_direct, edx, [param]
	cmp	eax, 1
	jne	.ELSIF2

	mov	eax, [param_1]
	mov	[value], eax
	jmp	.END

.ELSIF2	invoke	is_indirect, edx, [param]
	cmp	eax, 1
	jne	.END

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	mov	[pc], eax

	invoke	get_size_param, edx
	mov	[size_param], eax

	mov	eax, [param_1]
	cdq
	idiv	dword [idx_mod]
	mov	[other], edx

	mov	eax, [pc]
	sub	eax, dword [size_param]
	add	eax, dword [other]

	cdq
	idiv	dword [mem_size]

	invoke	read_arena, [core], edx, 4
	mov	[value], eax

.END	mov	eax, [value]

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, eax
	; popx	eax, ebx, ecx, edx

	popx	ecx, edx

endproc