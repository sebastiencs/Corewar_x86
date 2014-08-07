
%include "corewar.inc"

section .data

str1:	db 'edx = %d', 10, 0

section .text

extern get_color_champions
extern set_color_with_pc

extern TTF_RenderText_Solid
extern disp_gui

global get_color

get_color:

	push	ebp
	mov	ebp, esp

	push	ecx
	push	edx
	push	ebx

	mov	eax, [ebp + 12]
	mov	eax, [eax + s_corewar.info_arena]
	;add	eax, s_corewar.info_arena
	add	eax, dword [ebp + 16]

	movzx	edx, byte [eax]

	push	dword edx
	push	dword [ebp + 8]
	call	get_color_champions
	add	esp, 8

	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	set_color_with_pc
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	ebx
	pop	edx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret
