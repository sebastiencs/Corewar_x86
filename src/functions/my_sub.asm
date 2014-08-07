;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_sub.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 22:35:30 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'SUB %d - %d = %d', 10, 0

section .text

extern is_good_register

proc	my_sub, core, champions, instruction

	_var_	value1, value2, sub_value, param0, param1, param2, reg_ptr

	pushx	edx

	mov	dword [value1], 0
	mov	dword [value2], 0
	mov	dword [sub_value], 0

	mov	eax, [instruction]
	mov	edx, [eax + s_instruction.params]
	mov	dword [param0], edx
	mov	edx, [eax + s_instruction.params + 4]
	mov	dword [param1], edx
	mov	edx, [eax + s_instruction.params + 8]
	mov	dword [param2], edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.reg]
	mov	dword [reg_ptr], eax

.1	invoke	is_good_register, [param0]
	cmp	eax, 1
	jne	.2

	mov	eax, [param0]
	shl	eax, 2
	mov	edx, [reg_ptr]
	add	edx, eax

	mov	eax, [edx]
	mov	dword [value1], eax

.2	invoke	is_good_register, [param1]
	cmp	eax, 1
	jne	.3

	mov	eax, [param1]
	shl	eax, 2
	mov	edx, [reg_ptr]
	add	edx, eax

	mov	eax, [edx]
	mov	dword [value2], eax

.3	mov	eax, [value1]
	sub	eax, dword [value2]
	mov	dword [sub_value], eax

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, [value1], [value2], [sub_value]
	; popx	eax, ebx, ecx, edx

	invoke	is_good_register, [param2]
	cmp	eax, 1
	jne	.CARRY

	mov	eax, [param2]
	shl	eax, 2
	mov	edx, [reg_ptr]
	add	edx, eax

	mov	eax, [sub_value]
	mov	[edx], eax

.CARRY	mov	eax, [champions]
	cmp	dword [sub_value], 0
	je	.ONE

	mov	dword [eax + s_champions.carry], 0
	jmp	.END

.ONE	mov	dword [eax + s_champions.carry], 1

.END	xor	eax, eax
	popx	edx

endproc