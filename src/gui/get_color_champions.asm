
%include "corewar.inc"

section .text

global get_color_champions

get_color_champions:

	push	ebp
	mov	ebp, esp

	push	eax
	push	edx

	movzx	edx, byte [ebp + 12]

	mov	eax, [ebp + 8]
	add	eax, s_gui.my_color

	mov	byte [eax + SDL_Color.r], 30
	mov	byte [eax + SDL_Color.g], 30
	mov	byte [eax + SDL_Color.b], 30
	mov	byte [eax + SDL_Color.unused], 0

	cmp	edx, 0
	je	.END

	cmp	edx, 4
	jg	.END

	cmp	edx, 1
	je	.ONE
	cmp	edx, 2
	je	.TWO
	cmp	edx, 3
	je	.THREE
	cmp	edx, 4
	je	.FOUR

	jmp	.END

.ONE	mov	byte [eax + SDL_Color.r], 0
	mov	byte [eax + SDL_Color.g], 255
	mov	byte [eax + SDL_Color.b], 0
	jmp	.END

.TWO	mov	byte [eax + SDL_Color.r], 0
	mov	byte [eax + SDL_Color.g], 0
	mov	byte [eax + SDL_Color.b], 255
	jmp	.END

.THREE	mov	byte [eax + SDL_Color.r], 255
	mov	byte [eax + SDL_Color.g], 255
	mov	byte [eax + SDL_Color.b], 0
	jmp	.END

.FOUR	mov	byte [eax + SDL_Color.r], 66
	mov	byte [eax + SDL_Color.g], 0
	mov	byte [eax + SDL_Color.b], 66

.END	pop	edx
	pop	eax
	mov	esp, ebp
	pop	ebp
	ret
