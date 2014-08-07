;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: write_arena_two.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 23:03:41 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	write_arena_two, core, champions, to_write, index

	_var_	mem_size, index_mod, index_one_mod

	pushx	eax, edx

	mov	dword [mem_size], MEM_SIZE

	mov	eax, [index]
	mov	edx, 0
	div	dword [mem_size]
	mov	[index_mod], edx

	mov	eax, [index]
	inc	eax
	mov	edx, 0
	div	dword [mem_size]
	mov	[index_one_mod], edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, dword [index_mod]
	mov	edx, [to_write]
	shr	edx, 8
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, dword [index_mod]
	mov	edx, [champions]
	mov	edx, [edx + s_champions.prog_number]
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, dword [index_one_mod]
	mov	edx, [to_write]
	and	edx, 0b11111111
	mov	byte [eax], dl

	mov	eax, [core]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, dword [index_one_mod]
	mov	edx, [champions]
	mov	edx, [edx + s_champions.prog_number]
	mov	byte [eax], dl

	popx	eax, edx

endproc