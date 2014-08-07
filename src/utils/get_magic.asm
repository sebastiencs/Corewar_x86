;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_magic.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 00:57:05 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: bad magic number with ', 0
str2:	db 10, 0
str3:	db 'error: read', 10, 0

section .text

extern little_to_big_endian
extern my_putstr
extern read

proc	get_magic, champions, fd

	_var_	buf

	pushx	ebx, ecx, edx

	mov	dword [buf], 0

	mov	eax, 3	     ; read
	mov	ebx, [fd]
	lea	ecx, [buf]
	mov	edx, 4	     ; size int
	int	80h

	_check_	.FAILR, -1

	mov	eax, [buf]
	bswap	eax

	IF	eax, ne, COREWAR_EXEC_MAGIC

		invoke	my_putstr, str1
		mov	eax, [champions]
		invoke	my_putstr, [eax + s_champions.filename]
		invoke	my_putstr, str2
		mov	eax, -1

	ELSE

		xor	eax, eax

	ENDIF

.END	popx	ebx, ecx, edx
	RET

.FAILR	invoke	my_putstr, str3
	mov	eax, -1
	jmp	.END

endproc
