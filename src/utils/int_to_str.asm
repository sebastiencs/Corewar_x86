;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: int_to_str.asm
;;  Author:   chapui_s
;;  Created:  18/07/2014 19:51:04 (+08:00 UTC)
;;  Updated:   5/08/2014 01:39:37 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	int_to_str, nb, string

	pushx	ebx, ecx, edx, edi

	mov	eax, [nb]
	mov	edi, [string]
	mov	ebx, 10
	xor	ecx, ecx

	IF	eax, l, 0

		mov	[edi], byte '-'
		inc	edi
		neg	eax

	ENDIF

.L1	cdq
	div	ebx
	push	edx
	inc	ecx
	cmp	eax, 0
	jne	.L1

.L2	pop	eax
	add	eax, '0'
	stosb
	loop	.L2

	xor	eax, eax
	stosb

	mov	eax, [string]

	popx	ebx, ecx, edx, edi

endproc
