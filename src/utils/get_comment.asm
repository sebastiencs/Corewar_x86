;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_comment.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 00:54:28 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: malloc', 10, 0
str2:	db 'error: read', 10, 0

section .text

extern my_putstr
extern malloc

proc	get_comment, champions, fd

	_var_	comment, i, buf

	pushx	ebx, ecx, edx

	invoke	malloc, (COMMENT_LENGTH + 1)
	_check_	.FAILM, 0

	mov	[comment], eax
	mov	edx, eax
	mov	dword [i], 0
	xor	ecx, ecx

	WHILE	dword [i], l, COMMENT_LENGTH

		push	edx

		mov	eax, 3		; read
		mov	ebx, [fd]
		lea	ecx, [buf]
		mov	edx, 1
		int	0x80

		pop	edx

		cmp	eax, 0
		jl	.FAILR
		jz	.AFTER

		IF	byte [buf], ne, 0

			mov	al, byte [buf]
			mov	[edx], al
			inc	edx

		ENDIF

		inc	dword [i]

	END_WHILE

.AFTER	mov	byte [edx], 0

	mov	eax, [champions]
	mov	edx, [comment]
	mov	[eax + s_champions.comment], edx
	xor	eax, eax

.END	popx	ebx, ecx, edx
	RET

.FAILM	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.END

.FAILR	invoke	my_putstr, str2
	mov	eax, -1
	jmp	.END

endproc
