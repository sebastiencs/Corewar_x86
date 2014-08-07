;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: hex_to_str.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 17:59:45 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	hex_to_str, nb, string

	pushx	ecx, edx, edi

	mov	edx, [nb]
	mov	edi, [string]
	mov	ecx, 3

.LOOP	rol	dl, 4
	movzx	eax, dl
	and	eax, 0xF

	IF	eax, l, 0xA

		add	eax, '0'

	ELSE

		add	eax, 'A' - 0x0A

	ENDIF

.NOT	stosb
	loop	.LOOP

	xor	eax, eax
	dec	edi
	stosb
	mov	eax, [string]

	popx	ecx, edx, edi

endproc