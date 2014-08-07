
%include "corewar.inc"

section .text

extern disp_gui
extern disp_core
extern disp_list

global get_list_pc

get_list_pc:

	push	ebp
	mov	ebp, esp

	push	ecx
	push	ebx
	push	edx

	mov	eax, [ebp + 12]
	mov	eax, [eax + s_gui.list_pc]
	mov	ebx, [ebp + 8]
	mov	ebx, [ebx + s_corewar.champions]

	mov	ecx, 0

.LOOP	cmp	ebx, 0
	je	.END

	cmp	ecx, ((MAX_PC * 2) - 1)
	jge	.END

	mov	edx, [ebx + s_champions.pc]
	mov	[eax], edx
	mov	edx, [ebx + s_champions.color_gui]
	mov	[eax + 4], edx

	add	eax, 8
	add	ecx, 2
	mov	ebx, [ebx + s_champions.next]
	jmp	.LOOP

.END	xor	eax, eax
	pop	edx
	pop	ebx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret
