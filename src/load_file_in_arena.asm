;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: load_file_in_arena.asm
;;  Author:   chapui_s
;;  Created:   6/08/2014 01:10:30 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern get_name_comment_champions
extern read
extern check_place_arena
extern check_size_read
extern my_putstr

proc	load_file_in_arena, arena, info_arena, champions

	_var_	fd, buf, size, i, s_read

	pushx	ebx, ecx, edx

	mov	ebx, [champions]

	WHILE	ebx, ne, 0

		mov	dword [size], 0
		mov	eax, [ebx + s_champions.load_address]
		mov	[i], eax

		lea	eax, [fd]
		invoke	get_name_comment_champions, ebx, eax
		_check_	.FAIL, -1

.LOOP		push	ebx

		mov	eax, 3
		mov	ebx, [fd]
		lea	ecx, [buf]
		mov	edx, 1
		int	0x80

		pop	ebx

		mov	[s_read], eax
		cmp	eax, 0
		jle	.ENDL

		inc	dword [size]

		mov	eax, [arena]
		mov	ecx, [i]
		mov	edx, [buf]
		mov	byte [eax + ecx], dl

		lea	eax, [i]
		invoke	check_place_arena, [info_arena], [ebx + s_champions.prog_number], eax
		_check_	.FAIL, -1

		IF	dword [i], e, (MEM_SIZE - 1)

			mov	dword [i], 0

		ENDIF

		jmp	.LOOP

.ENDL		invoke	check_size_read, [size], ebx, [fd], [s_read]
		_check_	.FAIL, -1

		mov	ebx, [ebx + s_champions.next]

	END_WHILE

	xor	eax, eax

.END	popx	ebx, ecx, edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc
