;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: swap_int.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 02:05:25 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	swap_int, a, b

	pushx	edx

	_var_	tmp

	mov	eax, [a]
	mov	eax, [eax]
	mov	[tmp], eax

	mov	eax, [b]
	mov	eax, [eax]
	mov	edx, [a]
	mov	[edx], eax

	mov	eax, [b]
	mov	edx, [tmp]
	mov	[eax], edx

	popx	edx

endproc
