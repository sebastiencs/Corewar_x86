;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_st.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 22:20:35 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

extern is_good_register
extern is_register
extern is_indirect
extern write_arena_four

section .text

proc	my_st, core, champions, instruction

	_var_	value_to_store, index, param0, param1, idx_mod

	pushx	edx

	mov	dword [value_to_store], 0
	mov	eax, [instruction]
	mov	edx, [eax + s_instruction.params]
	mov	dword [param0], edx
	mov	edx, [eax + s_instruction.params + 4]
	mov	dword [param1], edx
	mov	dword [idx_mod], IDX_MOD

	invoke	is_good_register, [param0]
	cmp	eax, 1
	jne	.THEN

	mov	eax, [param0]
	shl	eax, 2

	mov	edx, [champions]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax

	mov	eax, dword [edx]
	mov	dword [value_to_store], eax

.THEN	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

	invoke	is_register, edx, 2
	cmp	eax, 1
	jne	.ELSEIF

	invoke	is_good_register, [param1]
	cmp	eax, 1
	jne	.END

	mov	eax, [param1]
	shl	eax, 2

	mov	edx, [champions]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax

	mov	eax, [value_to_store]
	mov	dword [edx], eax
	jmp	.END

.ELSEIF	invoke	is_indirect, edx, 2
	cmp	eax, 1
	jne	.END

	xor	edx, edx
	mov	eax, [param1]
	cmp	eax, 0
	jge	.NO
	mov	edx, -1
.NO	idiv	dword [idx_mod]

.TEST	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	sub	eax, 5
	add	eax, edx

	invoke	write_arena_four, [core], [champions], [value_to_store], eax

.END	xor	eax, eax
	popx	edx

endproc