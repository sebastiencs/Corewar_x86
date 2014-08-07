;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_cycle_to_wait.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 12:11:09 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

fucking_cycles:
	dd	10, 5, 5, 10, 10, 6, 6, 6, 20, 25, 25, 800, 10, 50, 1000, 2

section .text

proc	get_cycle_to_wait, core, champions

	_var_	index, mem_size

	pushx	eax, edx

	mov	dword [mem_size], MEM_SIZE

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	xor	edx, edx
	cmp	eax, 0
	jge	.NO
	mov	edx, -1
.NO	idiv	dword [mem_size]
	mov	[index], edx

.LOOP	cmp	dword [index], 0
	jge	.ENDL

	add	dword [index], MEM_SIZE
	jmp	.LOOP

.ENDL	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, [index]
	movzx	edx, byte [eax]

	cmp	edx, 1
	jl	.ELSE

	cmp	edx, 16
	jg	.ELSE

	dec	edx
	shl	edx, 2
	mov	edx, [fucking_cycles + edx]
	mov	eax, [champions]
	mov	[eax + s_champions.cycle_to_wait], edx
	popx	eax, edx
	jmp	.endproc

.ELSE	mov	eax, [champions]
	mov	dword [eax + s_champions.cycle_to_wait], 0
	popx	eax, edx

endproc