;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_lld.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 22:04:44 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern read_arena
extern is_indirect
extern is_direct
extern is_good_register

proc	my_lld, core, champions, instruction

	_var_	value_to_load, pc, param0

	pushx	edx

	mov	dword [value_to_load], 0

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	mov	[pc], eax

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params]
	mov	dword [param0], eax

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

.IF	invoke	is_indirect, edx, 1
	cmp	eax, 1
	jne	.ELSEIF

	mov	eax, [pc]
	add	eax, dword [param0]
	invoke	read_arena, [core], eax, 4
	mov	dword [value_to_load], eax
	jmp	.THEN

.ELSEIF	invoke	is_direct, edx, 1
	cmp	eax, 1
	jne	.THEN

	mov	eax, [param0]
	mov	dword [value_to_load], eax

.THEN	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 4]
	mov	edx, eax
	invoke	is_good_register, eax
	cmp	eax, 1
	jne	.CARRY

	mov	eax, edx
	shl	eax, 2
	mov	edx, [champions]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax

	mov	eax, [value_to_load]
	mov	[edx], eax

.CARRY	cmp	dword [value_to_load], 0
	je	.ONE

	xor	eax, eax
	jmp	.END

.ONE	mov	eax, 1

.END	mov	edx, [champions]
	mov	[edx + s_champions.carry], eax

	xor	eax, eax
	popx	edx

endproc