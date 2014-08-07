;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_second_value.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 21:37:07 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern is_register
extern is_good_register
extern is_direct

proc	get_second_value, core, champions, instruction

	_var_	second_value, param1

	pushx	edx

	mov	dword [second_value], 0
	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 4]
	mov	dword [param1], eax

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

.IF	invoke	is_register, edx, 2
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
	mov	eax, [edx]
	mov	dword [second_value], eax
	jmp	.END

.ELSEIF	invoke	is_direct, edx, 2
	cmp	eax, 1
	jne	.END

	mov	eax, [param1]
	mov	dword [second_value], eax

.END	mov	eax, [second_value]

	popx	edx

endproc