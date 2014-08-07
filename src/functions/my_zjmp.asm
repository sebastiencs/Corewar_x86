;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_zjmp.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 22:53:54 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	my_zjmp, core, champions, instruction

	_var_	param0, pc, mem_size, idx_mod

	pushx	ebx, edx

	mov	eax, [champions]
	cmp	dword [eax + s_champions.carry], 1
	jne	.END

	mov	edx, [eax + s_champions.pc]
	mov	dword [pc], edx

	mov	dword [idx_mod], IDX_MOD
	mov	dword [mem_size], MEM_SIZE

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params]
	cdq
	idiv	dword [idx_mod]

	mov	eax, [pc]
	sub	eax, 3
	add	eax, edx

	cdq
	idiv	dword [mem_size]

.LOOP	cmp	edx, 0
	jge	.ENDL

	add	edx, MEM_SIZE
	jmp	.LOOP

.ENDL	mov	eax, [champions]
	mov	[eax + s_champions.pc], edx

.END	xor	eax, eax
	popx	ebx, edx

endproc