;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: to_negativ.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 20:37:22 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern my_putnbr

proc	to_negativ, nb, nb_octet

	_var_	result, tmp, decal

	mov	dword [result], 0
	mov	dword [decal], 0

	cmp	dword [nb_octet], 4
	jne	.OR

	mov	eax, [nb]
	and	eax, 0b1000000000000000000000000000000
	cmp	eax, 0
	je	.OR

	jmp	.DO

.OR	cmp	dword [nb_octet], 2
	jne	.END

	and	eax, 0b100000000000000
	cmp	eax, 0
	je	.END

.DO	IF	dword [nb_octet], e, 4

.TEST		xor	eax, eax
		mov	eax, [nb]
		; xor	eax, 0b11111111111111111111111111111111
		or	eax, 0b10000000000000000000000000000000
		; inc	eax
		; neg	eax

	ELSEIF	dword [nb_octet], e, 2

		xor	eax, eax
		mov	eax, [nb]
		xor	ax, 0b1111111111111111
		inc	ax
		neg	eax

	ENDIF
	mov	dword [nb], eax
	RET

.END	mov	eax, [nb]

endproc
