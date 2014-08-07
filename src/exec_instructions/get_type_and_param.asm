;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_type_and_param.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 00:21:56 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern read_arena
extern fulfil_param

proc	get_type_and_param, core, champions, instruction

	_var_	code, mem_size

	pushx	eax, edx

	mov	dword [mem_size], MEM_SIZE

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.code]

	mov	[code], edx

	cmp	edx, LIVE
	je	.ELSE

	cmp	edx, ZJMP
	je	.ELSE

	cmp	edx, FORK
	je	.ELSE

	cmp	edx, LFORK
	je	.ELSE

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	inc	eax
	cdq
	idiv	dword [mem_size]

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, edx
	mov	al, byte [eax]

	mov	edx, [instruction]
	add	edx, s_instruction.type

	mov	byte [edx], al

	invoke	fulfil_param, [core], [champions], [instruction]
	jmp	.END

.ELSE	nop

	mov	eax, [instruction]
	add	eax, s_instruction.type
	mov	byte [eax], 0

	IF	byte [code], e, LIVE

		mov	eax, [champions]
		mov	eax, [eax + s_champions.pc]
		inc	eax
		invoke	read_arena, [core], eax, 4
		mov	edx, [instruction]
		add	edx, s_instruction.params
		mov	[edx], eax

		mov	eax, [champions]
		add	dword [eax + s_champions.pc], 5
		; mov	eax, [eax + s_champions.pc]
		; add	eax, 5
		; mov	edx, [champions]
		; mov	dword [edx + s_champions.pc], eax

	ELSE

		mov	eax, [champions]
		mov	eax, [eax + s_champions.pc]
		inc	eax
		invoke	read_arena, [core], eax, 2
		mov	edx, [instruction]
		add	edx, s_instruction.params
		mov	[edx], eax

		mov	eax, [champions]
		add	dword [eax + s_champions.pc], 3
		; mov	eax, [eax + s_champions.pc]
		; add	eax, 3
		; mov	edx, [champions]
		; mov	dword [edx + s_champions.pc], eax

	ENDIF

.END	popx	eax, edx

endproc