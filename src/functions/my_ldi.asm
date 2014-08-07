;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_ldi.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 21:46:17 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'LDI: first = %d second = %d read_value = %d', 10, 0
str2: db 'PTR LDI = %d', 10, 0

section .text

extern get_first_value
extern get_second_value
extern read_arena
extern is_register
extern is_good_register

extern printf

proc	my_ldi, core, champions, instruction

	_var_	first_value, second_value, read_value, idx_mod

	pushx	edx

	mov	dword [idx_mod], IDX_MOD

	invoke	get_first_value, [core], [champions], [instruction], 0
	mov	dword [first_value], eax

	invoke	get_second_value, [core], [champions], [instruction]
	mov	dword [second_value], eax

.TEST	nop

	mov	eax, [first_value]
	add	eax, dword [second_value]
	xor	edx, edx
	cmp	eax, 0
	jge	.NO
	not	edx
.NO	idiv	dword [idx_mod]
	mov	dword [read_value], edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	sub	eax, 6
	add	eax, dword [read_value]

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str2, eax
	; popx	eax, ebx, ecx, edx

	invoke	read_arena, [core], eax, 4
	mov	dword [read_value], eax

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, [first_value], [second_value], [read_value]
	; popx	eax, ebx, ecx, edx


	invoke	is_register, edx, 3
	cmp	eax, 1
	jne	.END

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 8]
	mov	edx, eax
	invoke	is_good_register, eax
	cmp	eax, 1
	jne	.END

	mov	eax, edx
	shl	eax, 2
	mov	edx, [champions]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax
	mov	eax, [read_value]
	mov	[edx], eax

	cmp	eax, 0
	je	.ONE

	xor	eax, eax
	jmp	.CARRY

.ONE	mov	eax, 1

.CARRY	mov	edx, [champions]
	mov	[edx + s_champions.carry], eax

.END	xor	eax, eax

	popx	edx

endproc