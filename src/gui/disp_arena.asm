;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: disp_arena.asm
;;  Author:   chapui_s
;;  Created:  16/07/2014 21:46:57 (+08:00 UTC)
;;  Updated:   6/08/2014 17:47:11 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: SDL_FillRect', 10, 0
str2:	db 'error: SDL_BlitSurface', 10, 0
str3:	db 'error: SDL_Flip', 10, 0

const:	dd 5

section .text

%define SDL_BlitSurface SDL_UpperBlit

extern SDL_FillRect
extern SDL_BlitSurface
extern SDL_Flip
extern get_list_pc
extern print_bytes
extern my_putstr
extern disp_info_players

extern disp_core
extern disp_gui

global disp_arena

disp_arena:

	push	ebp
	mov	ebp, esp

	push	edx

	cmp	dword [ebp + 20], 1
	je	.START

	mov	edx, 0
	mov	eax, [ebp + 16]
	div	dword [const]
	xor	eax, eax
	cmp	edx, 0
	jne	.END

.START	mov	eax, [ebp + 12]

	push	dword 0
	push	dword 0
	push	dword [eax + s_gui.screen]
	call	SDL_FillRect wrt ..plt
	add	esp, 12
	cmp	eax, 0
	jl	.FAILFR

	mov	eax, [ebp + 12]
	lea	edx, [eax + s_gui.pos_background]
	push	dword edx
	push	dword [eax + s_gui.screen]
	push	dword 0
	push	dword [eax + s_gui.background]
	call	SDL_BlitSurface
	add	esp, 16
	cmp	eax, 0
	jl	.FAILB

	push	dword [ebp + 20]
	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	disp_info_players
	add	esp, 16
	cmp	eax, -1
	je	.FAIL


	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_list_pc
	add	esp, 8

	push	dword [ebp + 12]
.TEST	push	dword [ebp + 8]
	call	print_bytes
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	mov	eax, [ebp + 12]
	push	dword [eax + s_gui.screen]
	call	SDL_Flip
	add	esp, 4
	cmp	eax, -1
	je	.FAILF

	xor	eax, eax
	jmp	.END

.FAILF	push	str3
	jmp	.STR

.FAILB	push	str2
	jmp	.STR

.FAILFR	push	str1
	jmp	.STR

.STR	call	my_putstr
	add	esp, 4

.FAIL	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
