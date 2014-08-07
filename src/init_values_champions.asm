
%include "corewar.inc"

section .data

str1:	db MALLOC_FAILED

section .text

extern init_reg
extern malloc
extern my_putstr

proc	init_values_champions, champions

	mov	edx, [champions]

	WHILE	edx, ne, 0

		push	edx

		invoke	malloc, (4 * (REG_NUMBER + 1))		; sizeof(int) * ...
		_check_	.FAIL, 0

		pop	edx
		mov	[edx + s_champions.reg], eax

		invoke	init_reg, [edx + s_champions.reg], [edx + s_champions.prog_number]

		mov	eax, [edx + s_champions.load_address]
		mov	[edx + s_champions.pc], eax

		mov	dword [edx + s_champions.carry], 0
		mov	dword [edx + s_champions.last_live], 0
		mov	dword [edx + s_champions.cycle_to_wait], 0

		mov	edx, [edx + s_champions.next]

	END_WHILE

	xor	eax, eax
	RET

.FAIL	invoke	my_putstr, str1
	mov	eax, -1

endproc
