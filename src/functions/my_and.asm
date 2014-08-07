;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_and.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 20:06:39 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'AND v1 = %d v2 = %d reg = %d', 10, 0

section .text

extern get_value
extern is_good_register

proc	my_and, core, champions, instruction

	_var_	value1, value2

	pushx	ecx, edx

	invoke	get_value, [core], [champions], [instruction], 1
	mov	[value1], eax

	invoke	get_value, [core], [champions], [instruction], 2
	mov	[value2], eax

	mov	eax, [value1]
	and	eax, dword [value2]
	mov	ecx, eax

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, [value1], [value2], 111
	; popx	eax, ebx, ecx, edx


	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 8]
	mov	edx, eax
	invoke	is_good_register, eax
	cmp	eax, 1
	jne	.NO

	mov	eax, [champions]
.TEST	mov	eax, [eax + s_champions.reg]

	mov	edx, [instruction]
	mov	edx, [edx + s_instruction.params + 8]
	shl	edx, 2
	mov	[eax + edx], ecx

	; mov	[eax + (edx * 4)], ecx

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, [value1], [value2], [eax + edx]
	; popx	eax, ebx, ecx, edx

.NO	cmp	ecx, 0
	je	.ONE

	mov	edx, 0
	jmp	.END

.ONE	mov	edx, 1

.END	mov	eax, [champions]
	mov	[eax + s_champions.carry], edx

	xor	eax, eax

	popx	ecx, edx

endproc