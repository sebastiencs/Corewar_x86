;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_name_comment_champions.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 01:20:23 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: lseek', 10, 0
str2:	db 'error: open', 10, 0

section .text

extern open
extern get_magic
extern lseek
extern get_name
extern get_size
extern get_comment
extern my_putstr

proc	get_name_comment_champions, champions, fd

	_var_	fd_int

	pushx	ebx, ecx, edx

	mov	eax, 5		    ; open
	mov	ebx, [champions]
	mov	ebx, [ebx + s_champions.filename]
	mov	ecx, O_RDONLY
	xor	edx, edx
	int	0x80
	_check_	.FAILO, -1

	mov	edx, [fd]
	mov	[edx], eax
	mov	[fd_int], eax

	invoke	get_magic, [champions], [fd_int]
	_check_	.FAIL, -1

	mov	eax, 19			; lseek
	mov	ebx, [fd_int]
	mov	ecx, 4			; size int
	mov	edx, SEEK_SET
	int	0x80
	_check_	.FAILS, -1

	invoke	get_name, [champions], [fd_int]
	_check_	.FAIL, -1

	mov	eax, 19			; lseek
	mov	ebx, [fd_int]
	mov	ecx, (4 + (PROG_NAME_LENGTH + 4))	; sizeof(int) + (PROG_NAME_LENGTH + 4)
	mov	edx, SEEK_SET
	int	0x80
	_check_	.FAILS, -1

	invoke	get_size, [champions], [fd_int]
	_check_	.FAIL, -1

	mov	eax, 19			; lseek
	mov	ebx, [fd_int]
	mov	ecx, (8 + (PROG_NAME_LENGTH + 4))	; (sizeof(int) * 2) + (PROG_NAME_LENGTH + 4)
	mov	edx, SEEK_SET
	int	0x80
	_check_	.FAILS, -1

	invoke	get_comment, [champions], [fd_int]
	_check_	.FAIL, -1

	mov	eax, 19			; lseek
	mov	ebx, [fd_int]
	mov	ecx, 2192				; sizeof(struct header_s)
	mov	edx, SEEK_SET
	int	0x80
	_check_	.FAIL, -1

	xor	eax, eax

.END	popx	ebx, ecx, edx
	RET

.FAILO	invoke	my_putstr, str2
	mov	eax, -1
	jmp	.END

.FAILS	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.END

.FAIL	mov	eax, -1
	jmp	.END

endproc
