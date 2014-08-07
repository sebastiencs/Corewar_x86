;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_strcat.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 01:51:43 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

extern malloc
extern my_strlen

proc	my_strcat, s1, s2

	_var_	len1, len2, ptr

	pushx	ecx, edi, esi
	pushfd

	invoke	my_strlen, [s1]
	mov	[len1], eax

	invoke	my_strlen, [s2]
	mov	[len2], eax

	add	eax, [len1]

	invoke	malloc, eax
	_check_	.END, 0

	mov	[ptr], eax
	cld

	mov	esi, [s1]
	mov	edi, eax
	mov	ecx, [len1]
	rep	movsb

	mov	esi, [s2]
	mov	ecx, [len2]
	rep	movsb

	mov	byte [edi], 0

	mov	eax, [ptr]

.END	popfd
	popx	ecx, edi, esi
	RET

endproc
