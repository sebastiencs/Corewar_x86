;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_xor.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 22:45:06 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


%include "corewar.inc"

section .text

extern get_value
extern is_good_register

proc	my_xor, core, champions, instruction

	_var_	value1, value2, xor_value, param2

	pushx	edx

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 8]
	mov	dword [param2], eax

	invoke	get_value, [core], [champions], [instruction], 1
	mov	dword [value1], eax
.TEST	nop
	invoke	get_value, [core], [champions], [instruction], 2
	mov	dword [value2], eax
	nop

	mov	eax, [value1]
	xor	eax, dword [value2]
	mov	dword [xor_value], eax

	invoke	is_good_register, [param2]
	cmp	eax, 1
	jne	.CARRY

	mov	eax, [param2]
	shl	eax, 2
	; mov	edx, 4
	; mul	edx

	mov	edx, [champions]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax

	mov	eax, dword [xor_value]
	mov	[edx], eax

.CARRY	mov	eax, [champions]
	cmp	dword [xor_value], 0
	je	.ONE

	mov	dword [eax + s_champions.carry], 0
	jmp	.END

.ONE	mov	dword [eax + s_champions.carry], 1

.END	xor	eax, eax
	popx	edx

endproc