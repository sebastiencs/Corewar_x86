;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: is_special.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 19:40:27 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


%include "corewar.inc"

section .text

proc	is_special, champions, instruction, decal

	pushx	edx

	mov	edx, [champions]
	mov	edx, [edx + s_champions.pc]

	mov	eax, [decal]
	sub	eax, edx
	mov	edx, eax

	mov	eax, [instruction]

.FIRST	cmp	byte [eax + s_instruction.code], STI
	jne	.SECOND

	cmp	edx, 3
	je	.SPEC

	cmp	edx, 5
	je	.SPEC

.SECOND	cmp	byte [eax + s_instruction.code], LDI
	jne	.THIRD

	cmp	edx, 2
	je	.SPEC

	cmp	edx, 4
	je	.SPEC

.THIRD	cmp	byte [eax + s_instruction.code], LLDI
	jne	.END

	cmp	edx, 2
	je	.SPEC

	cmp	edx, 4
	je	.SPEC

.END	xor	eax, eax
	popx	edx
	jmp	.ENDPROC

.SPEC	mov	eax, 1
	popx	edx

endproc