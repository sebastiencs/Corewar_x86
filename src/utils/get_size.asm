;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_size.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 01:33:09 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: read', 10, 0
str2:	db 'error while loading file', 10, 0
str3:	db 'error: size indicate in file different from true size, maybe the file is corrupt: ', 0
str4:	db 10, 0

section .text

extern close
extern my_putstr
extern read

proc	check_size_read, size, champions1, fd1, s_read

	invoke	close, [fd1]

	IF	dword [s_read], e, -1

		invoke	my_putstr, str1
		mov	eax, -1
		jmp	.FAIL

	ENDIF

	IF	dword [champions1], e, 0

		invoke	my_putstr, str2
		jmp	.FAIL

	ENDIF

	mov	eax, [champions1]
	mov	eax, [eax + s_champions.size]

	IF	[size], ne, eax

		invoke	my_putstr, str3
		invoke	my_putstr, [eax + s_champions.filename]
		invoke	my_putstr, str4
		jmp	.FAIL

	ENDIF

.END	xor	eax, eax
	RET

.FAIL	mov	eax, -1

endproc

proc	get_size, champions, fd

	_var_	buf

	pushx	ebx, ecx, edx

	mov	dword [buf], 0

	mov	eax, 3
	mov	ebx, [fd]
	lea	ecx, [buf]
	mov	edx, 4
	int	0x80
	_check_	.FAIL, -1

	mov	eax, [buf]

	bswap	eax	; putin d'instruction

	mov	edx, [champions]
	mov	[edx + s_champions.size], eax

	xor	eax, eax
.END	popx	ebx, ecx, edx
	RET

.FAIL	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.END

endproc
