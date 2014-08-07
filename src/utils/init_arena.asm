;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: init_arena.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 01:33:48 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	init_arena, ptr, size, value

	pushx	eax, edi, ecx
	pushfd

	mov	eax, [value]
	mov	edi, [ptr]
	mov	ecx, [size]
	cld

	repne	stosb

	popfd
	popx	eax, edi, ecx

endproc
