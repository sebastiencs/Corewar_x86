;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_sti.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 23:04:54 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'STI ptr = %d', 10, 0
str2: db 'STI value_to_store = %d value2 = %d value3 = %d', 10, 0

section .text

extern is_good_register
extern is_register
extern is_direct
extern is_indirect
extern write_arena_four

extern disp_inst

proc	get_value_to_store, core1, champions1, instruction1

	_var_	value, param0

	pushx	edx

	mov	dword [value], 0

	mov	eax, [instruction1]
	movzx	edx, byte [eax + s_instruction.type]
	mov	eax, [eax + s_instruction.params]
	mov	[param0], eax

	invoke	is_register, edx, 1
	cmp	eax, 1
	jne	.END

	invoke	is_good_register, [param0]
	cmp	eax, 1
	jne	.END

	mov	eax, [param0]
	shl	eax, 2

	mov	edx, [champions1]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax
	mov	eax, [edx]
	mov	dword [value], eax

.END	mov	eax, [value]
	popx	edx

endproc

proc	get_second_value_sti, core2, champions2, instruction2

	_var_	second_value, param1

	pushx	edx

	mov	dword [second_value], 0
	mov	eax, [instruction2]
	mov	eax, [eax + s_instruction.params + 4]
	mov	dword [param1], eax

	mov	eax, [instruction2]
	movzx	edx, byte [eax + s_instruction.type]

.1	invoke	is_register, edx, 2
	cmp	eax, 1
	jne	.2

	invoke	is_good_register, [param1]
	cmp	eax, 1
	jne	.END

	mov	eax, [param1]
	shl	eax, 2
	; mov	edx, 4
	; mul	edx

	mov	edx, [champions2]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax
	mov	edx, [edx]
	mov	dword [second_value], edx
	jmp	.END

.2	invoke	is_direct, edx, 2
	cmp	eax, 1
	jne	.3

	mov	eax, [param1]
	mov	dword [second_value], eax
	jmp	.END

.3	invoke	is_indirect, edx, 2
	cmp	eax, 1
	jne	.END

	mov	eax, [param1]
	mov	dword [second_value], eax

.END	mov	eax, [second_value]
	popx	edx

endproc

proc	get_third_value, core3, champions3, instruction3

	_var_	third_value, param2

	pushx	edx

	mov	dword [third_value], 0
	mov	eax, [instruction3]
	mov	eax, [eax + s_instruction.params + 8]
	mov	dword [param2], eax

.TEST	mov	eax, [instruction3]
	movzx	edx, byte [eax + s_instruction.type]

.1	invoke	is_register, edx, 3
	cmp	eax, 1
	jne	.2

	invoke	is_good_register, [param2]
	cmp	eax, 1
	jne	.END

	mov	eax, [param2]
	shl	eax, 2
	; mov	edx, 4
	; mul	edx

	mov	edx, [champions3]
	mov	edx, [edx + s_champions.reg]
	add	edx, eax
	mov	edx, [edx]
	mov	dword [third_value], edx
	jmp	.END

.2	invoke	is_direct, edx, 3
	cmp	eax, 1
	jne	.END

	mov	eax, [param2]
	mov	dword [third_value], eax

.END	mov	eax, dword [third_value]
	popx	edx

endproc

proc	my_sti, core, champions, instruction

	_var_	value1, value2, value3, ptr, mem_size, idx_mod

	pushx	edx

	mov	dword [mem_size], MEM_SIZE
	mov	dword [idx_mod], IDX_MOD

	invoke	get_value_to_store, [core], [champions], [instruction]
	mov	dword [value1], eax

	invoke	get_second_value_sti, [core], [champions], [instruction]
	xor	edx, edx
.TEST	cmp	eax, 0
	jge	.NO
	mov	edx, -1
.NO	idiv	dword [idx_mod]
	mov	dword [value2], edx

	invoke	get_third_value, [core], [champions], [instruction]
	xor	edx, edx
	cmp	eax, 0
	jge	.NO2
	mov	edx, -1
.NO2	idiv	dword [idx_mod]
	mov	dword [value3], edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	sub	eax, 7
	add	eax, dword [value2]
	add	eax, dword [value3]

	xor	edx, edx
	cmp	eax, 0
	jge	.NO3
	mov	edx, -1
.NO3	idiv	dword [mem_size]

	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str2, [value1], [value2], [value3]
	; popx	eax, ebx, ecx, edx
	; pushx	eax, ebx, ecx, edx
	; invoke	disp_inst, [instruction]
	; popx	eax, ebx, ecx, edx
	; pushx	eax, ebx, ecx, edx
	; invoke	printf, str1, edx
	; popx	eax, ebx, ecx, edx

.LOOP	cmp	edx, 0
	jge	.ENDL

	add	edx, MEM_SIZE
	jmp	.LOOP

.ENDL	invoke	write_arena_four, [core], [champions], [value1], edx

	mov	eax, [champions]
	cmp	dword [value1], 0
	je	.ONE

	mov	dword [eax + s_champions.carry], 0
	jmp	.END

.ONE	mov	dword [eax + s_champions.carry], 1

.END	xor	eax, eax
	popx	edx

endproc