 
%include "corewar.inc"

section .data

str1:	db 'Corewar.bmp', 0
str2:	db 'arial.ttf', 0
str3:	db 'error: SDL_LoadBMP', 10, 0
str4:	db 'error: TTF_OpenFont', 10, 0
str5:	db 'rb', 0

section .text

extern my_putstr
extern SDL_RWFromFile
extern TTF_OpenFont
extern SDL_LoadBMP_RW

global get_image_path

get_image_path:

	push	ebp
	mov	ebp, esp

	push	edx

	push	str5
	push	str1
	call	SDL_RWFromFile
	add	esp, 8

	push	dword 1
	push	eax
	call	SDL_LoadBMP_RW
	add	esp, 8
	cmp	eax, 0
	je	.FAILL

	mov	edx, [ebp + 8]
	mov	[edx + s_gui.background], eax

	push	dword 11
	push	str2
	call	TTF_OpenFont
	add	esp, 8
	cmp	eax, 0
	je	.FAILO

	mov	edx, [ebp + 8]
	mov	[edx + s_gui.font], eax

	push	dword 13
	push	str2
	call	TTF_OpenFont
	add	esp, 8
	cmp	eax, 0
	je	.FAILO

	mov	edx, [ebp + 8]
	mov	[edx + s_gui.font_info], eax

	xor	eax, eax
	jmp	.END

.FAILL	push	str3
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILO	push	str4
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
