;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_fork.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 20:25:39 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern disp_reg

extern push_champion
extern copy_reg

proc	my_fork, core, champions, instruction

	_var_	new_pc, param0, mem_size, idx_mod

	pushx	ebx, edx

	mov	dword [mem_size], MEM_SIZE
	mov	dword [idx_mod], IDX_MOD

	mov	eax, [instruction]
	add	eax, s_instruction.params
	cmp	dword [eax], 0
	jne	.NEXT

	mov	dword [eax], 3

.NEXT	mov	eax, [eax]
	; xor	edx, edx
	; cmp	eax, 0
	; jge	.NO
	; mov	edx, -1
	cdq
.NO	idiv	dword [idx_mod]
	mov	[param0], edx
	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	sub	eax, 3
	add	eax, [param0]
	mov	dword [new_pc], eax

.LOOP	cmp	dword [new_pc], 0
	jge	.ENDL

	add	dword [new_pc], MEM_SIZE
	jmp	.LOOP

.ENDL	mov	eax, [new_pc]
	cdq
	idiv	dword [mem_size]
	mov	[new_pc], edx

	mov	eax, [champions]
	invoke	push_champion, [core], [eax + s_champions.filename], [eax + s_champions.prog_number], [new_pc]
	_check_	.FAIL, -1

	mov	eax, [core]
	mov	eax, [eax + s_corewar.last_champions]
	mov	ebx, eax

	mov	eax, [champions]
	mov	edx, [eax + s_champions.name]
	mov	[ebx + s_champions.name], edx
	mov	edx, [eax + s_champions.comment]
	mov	[ebx + s_champions.comment], edx
	mov	edx, [core]
	inc	dword [edx + s_corewar.prog_number_max]
	mov	edx, [edx + s_corewar.prog_number_max]
	mov	[ebx + s_champions.prog_number], edx
	mov	edx, [eax + s_champions.carry]
	mov	[ebx + s_champions.carry], edx
	mov	dword [ebx + s_champions.last_live], 0
	mov	dword [ebx + s_champions.cycle_to_wait], 2
	mov	edx, [eax + s_champions.color_gui]
	mov	[ebx + s_champions.color_gui], edx
	mov	edx, [new_pc]
	mov	[ebx + s_champions.pc], edx

	invoke	copy_reg, [eax + s_champions.reg]
	_check_	.FAIL, 0

;	invoke	disp_reg, eax

	mov	[ebx + s_champions.reg], eax
	mov	eax, [core]
	inc	dword [eax + s_corewar.nb_champions]

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	popx	ebx, edx


endproc