;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_showmem.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 14:39:37 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .data

_16:		dd	16
_32:		dd	32
base_str:	db	'0123456789ABCDEF', 0

section .text

extern my_putchar

proc	my_put_hexa, nb, base, is_first

.1	cmp	dword [nb], 16
	jge	.2

	cmp	dword [is_first], 1
	jne	.2

	invoke	my_putchar, '0'

.2	cmp	dword [nb], 16
	jl	.3

	mov	eax, [nb]
	xor	edx, edx
	div	dword [_16]
	invoke	my_put_hexa, eax, [base], 0

.3	mov	eax, [nb]
	xor	edx, edx
	cmp	eax, 0
	jge	.NO
	mov	edx, -1
.NO	idiv	dword [_16]
	mov	eax, [base]
	add	eax, edx
	invoke	my_putchar, [eax]

endproc

proc	write_hex, i_cur, line_cur1, size1, string1

	_var_	tmp

	mov	eax, [line_cur1]
	mul	dword [_32]
	add	eax, 32
	mov	[tmp], eax

.LOOP	mov	eax, [i_cur]
	cmp	eax, [tmp]
	jge	.endproc

	cmp	eax, [size1]
	jge	.endproc

	mov	edx, [string1]
	add	edx, eax
	movzx	edx, byte [edx]
	invoke	my_put_hexa, edx, base_str, 1
	inc	dword [i_cur]

	jmp	.LOOP

endproc

proc	my_showmem, string, size

	_var_	nb_lines, line_cur, i

	pushx	edx

	mov	dword [line_cur], 0
	mov	dword [i], 0
	mov	eax, [size]
	xor	edx, edx
	div	dword [_32]
	inc	eax
	mov	[nb_lines], eax

.LOOP	mov	eax, [line_cur]
	cmp	eax, [nb_lines]
	jge	.END

	mov	eax, [i]
	cmp	eax, [size]
	jge	.END

	invoke	write_hex, [i], [line_cur], [size], [string]
	invoke	my_putchar, 10
	inc	dword [line_cur]
	mov	eax, [line_cur]
	mul	dword [_32]
	mov	[i], eax

	jmp	.LOOP

.END	xor	eax, eax
	popx	edx

endproc