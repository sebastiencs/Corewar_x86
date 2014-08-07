
%include "corewar.inc"

section .data

str1:	db 'error: TTF_RenderText', 10, 0

section .text

extern TTF_RenderText_Shaded
extern TTF_RenderText_Solid
extern my_putstr
extern is_pc
extern hex_to_str

extern printf
extern disp_core

global set_color_with_pc

set_color_with_pc:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	; [ebp - 4]  fg_color
	; [ebp - 8]  str[0]
	; [ebp - 9]  str[1]
	; [ebp - 10] str[2]
	push	edx
	push	ebx

	mov	dword [ebp - 4], 0

	mov	edx, [ebp + 16]

;	invoke	disp_core, [ebp + 12]

	; problem de ptr ici !

	lea	eax, [ebp - 8]
	push	eax
	mov	eax, [ebp + 12]
	mov	eax, [eax + s_corewar.arena]
	add	eax, edx
	mov	ebx, eax
	mov	eax, 0
	mov	al, byte [ebx]
	push	eax
	call	hex_to_str
	add	esp, 8

.IF	push	dword [ebp + 16]
	push	dword [ebp + 8]
	push	dword [ebp + 12]
	call	is_pc
	add	esp, 12
	cmp	eax, 0
	je	.ELSE

	mov	eax, [ebp + 8]
	mov	eax, [eax + s_gui.my_color]
	push	eax
	push	dword [ebp - 4]
	lea	eax, [ebp - 8]
	push	eax
	mov	eax, [ebp + 8]
	mov	eax, [eax + s_gui.font]
	push	eax
	call	TTF_RenderText_Shaded
	add	esp, 16

;	invoke	disp_core, [ebp + 12]

	mov	edx, [ebp + 8]
	mov	[edx + s_gui.byte_arena], eax
	jmp	.ENDIF

.ELSE	mov	eax, [ebp + 8]
	mov	eax, [eax + s_gui.my_color]
	push	eax
	lea	eax, [ebp - 8]
	push	eax
	mov	eax, [ebp + 8]
	mov	eax, [eax + s_gui.font]
	push	eax
	call	TTF_RenderText_Solid
	add	esp, 12

;	invoke	printf, str1

	mov	edx, [ebp + 8]
	mov	[edx + s_gui.byte_arena], eax

.ENDIF	xor	eax, eax
	cmp	dword [edx + s_gui.byte_arena], 0
	jne	.END

.FAIL	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
