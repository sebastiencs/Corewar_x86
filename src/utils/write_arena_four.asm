;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: write_arena_four.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 23:21:05 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	write_arena_four, core, champions, to_write, index

	_var_	mem_size, index_mod, index_one_mod, index_two_mod, index_three_mod, color

	pushx	eax, edx

	mov	dword [mem_size], MEM_SIZE
	mov	eax, [champions]
	mov	eax, [eax + s_champions.color_gui]

	; inc	eax

	mov	[color], eax

.LOOP	cmp	dword [index], 0
	jge	.ENDL

	mov	eax, [index]
	add	eax, MEM_SIZE
	mov	[index], eax
	jmp	.LOOP

.ENDL	mov	eax, [index]
	cdq
	idiv	dword [mem_size]
	mov	[index_mod], edx

	mov	eax, [index]
	inc	eax
	cdq
	idiv	dword [mem_size]
	mov	[index_one_mod], edx

	mov	eax, [index]
	add	eax, 2
	cdq
	idiv	dword [mem_size]
	mov	[index_two_mod], edx

	mov	eax, [index]
	add	eax, 3
	cdq
	idiv	dword [mem_size]
	mov	[index_three_mod], edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, [index_mod]
	mov	edx, [to_write]
	shr	edx, 24
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, [index_mod]
	mov	edx, [color]
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, [index_one_mod]
	mov	edx, [to_write]
	and	edx, 0b00000000111111110000000000000000
	shr	edx, 16
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, [index_one_mod]
	mov	edx, [color]
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, [index_two_mod]
	mov	edx, [to_write]
	and	edx, 0b00000000000000001111111100000000
	shr	edx, 8
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, [index_two_mod]
	mov	edx, [color]
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, [index_three_mod]
	mov	edx, [to_write]
	and	edx, 0b00000000000000000000000011111111
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, [index_three_mod]
	mov	edx, [color]
	mov	byte [eax], dl

	popx	eax, edx

endproc