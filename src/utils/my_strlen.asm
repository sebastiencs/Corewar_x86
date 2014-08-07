;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_strlen.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 15:41:47 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	my_strlen, string

	pushx	ecx, edi

	xor	eax, eax
	mov	ecx, 0xffffffff
	mov	edi, [string]
	cld

	repne	scasb

	not	ecx
	dec	ecx

	mov	eax, ecx
	popx	ecx, edi

endproc
