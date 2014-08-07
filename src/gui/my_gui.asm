
%include "corewar.inc"

section .data

str1:	db 'error: SDL_Init: ', 10, 0
str2:	db 'error: SDL_SetVideoMode', 10, 0
str3:	db 'Corewar ASM', 0
str4:	db 'error: malloc', 10, 0

str5:	db 'OK', 10, 0

t_gui:
istruc	s_gui
  times 14	dd	0
iend

section .text

extern SDL_Init
extern SDL_SetVideoMode
extern SDL_WM_SetCaption
extern TTF_Init
extern my_putstr
extern malloc
extern get_image_path
extern get_color_champions
extern put_background
extern get_arena
extern disp_gui

global my_gui

my_gui:

	push	ebp
	mov	ebp, esp

	push	edx

	push	dword SDL_INIT_VIDEO
	call	SDL_Init
	add	esp, 4
	cmp	eax, -1
	je	.FAILI

	push	dword SDL_HWSURFACE
	push	dword 32
	push	dword WIN_Y
	push	dword WIN_X
	call	SDL_SetVideoMode
	add	esp, 16
	cmp	eax, 0
	je	.FAILS

	mov	edx, t_gui
	mov	[edx + s_gui.screen], eax

	push	dword 0
	push	str3
	call	SDL_WM_SetCaption
	add	esp, 8

	call	TTF_Init
	cmp	eax, -1
	je	.FAILT

	push	dword [ebp + 12]
	push	t_gui
	push	dword [ebp + 8]
	call	put_background
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	push	(4 * (MAX_PC * 2))
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAILM

	mov	edx, t_gui
	mov	[edx + s_gui.list_pc], eax

; TO RM
;.TEST	invoke	disp_gui, t_gui



	push	dword t_gui
	push	dword [ebp + 8]
	call	get_arena
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAILI	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILS	push	str2
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILT	push	str3
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILM	push	str4
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
