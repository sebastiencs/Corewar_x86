
%include "corewar.inc"

section .text

extern get_image_path
extern load_players_name

global put_background

put_background:

	push	ebp
	mov	ebp, esp

	mov	eax, [ebp + 12]
	add	eax, s_gui.pos_background
	mov	word [eax + SDL_Rect.x], 0
	mov	word [eax + SDL_Rect.y], 705

	push	dword [ebp + 16]
	push	dword [ebp + 12]
	call	get_image_path
	add	esp, 8
	cmp	eax, 0
	jne	.FAIL

	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	load_players_name
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	mov	esp, ebp
	pop	ebp
	ret
