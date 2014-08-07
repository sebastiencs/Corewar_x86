
%include "corewar.inc"

section .data

str1:	db 'error: SDL_BlitSurface', 10, 0

str2:	db 'cur = %d', 10, 0

section .text

extern get_color
extern SDL_UpperBlit    ;SDL_BlitSurface
extern SDL_FreeSurface
extern my_putstr

extern printf

global print_bytes

print_bytes:

	push	ebp
.TE	mov	ebp, esp

	sub	esp, 8
	; [ebp - 8]  position (2 * dword)

	mov	dword [ebp - 4], 0
	mov	dword [ebp - 8], 0
	mov	ecx, 0

.LOOP	cmp	ecx, MEM_SIZE
	jge	.END

	push	dword ecx
	push	dword [ebp + 8]
	push	dword [ebp + 12]
	call	get_color
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	push	ecx
	lea	eax, [ebp - 8]
	push	dword eax
	mov	eax, [ebp + 12]
;	add	eax, s_gui.screen
	mov	eax, [eax + s_gui.screen]
	push	eax
	push	dword 0
	mov	eax, [ebp + 12]
	mov	eax, [eax + s_gui.byte_arena]
	push	dword eax
.OL	call	SDL_UpperBlit
	add	esp, 16
	cmp	eax, 0
	jl	.FAILB

	pop	ecx

	lea	eax, [ebp - 8]
	add	word [eax + SDL_Rect.x], 14

.IF	cmp	ecx, 0
	jle	.ENDIF

	mov	edx, 0
	mov	eax, ecx
	inc	eax
	mov	ebx, 96
	div	ebx
	cmp	edx, 0
	jne	.ENDIF

	lea	eax, [ebp - 8]
	mov	word [eax + SDL_Rect.x], 0
	add	word [eax + SDL_Rect.y], 11

.ENDIF	push	ecx
	mov	eax, [ebp + 12]
	mov	eax, [eax + s_gui.byte_arena]
	push	dword eax
	call	SDL_FreeSurface
	add	esp, 4
	pop	ecx
	inc	ecx
	jmp	.LOOP

.FAILB	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	mov	esp, ebp
	pop	ebp
	ret

.FAIL	mov	eax, -1
	mov	esp, ebp
	pop	ebp
	ret

.END	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
