;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;  Filename: disp_info_players.asm
;;  Author:   chapui_s
;;  Created:  18/07/2014 19:13:50 (+08:00 UTC)
;;  Updated:  19/07/2014 18:07:37 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'PLAYING', 0
str2:	db 'PAUSED', 0
str3:	db 'error: SDL_BlitSurface', 10, 0

str:	  times 50	db	0
position: times 2	dd	0

section .text

extern TTF_RenderText_Solid
extern int_to_str
extern SDL_BlitSurface
extern my_putstr
extern disp_players

proc	disp_info_players, core, gui, cycles, paused

	_var_	color, font_info, screen, byte_arena

	invoke	disp_players, [gui]
	_check_	.FAIL, -1

	mov	dword [color], 0xffffffff
	mov	eax, [gui]
	mov	edx, [eax + s_gui.font_info]
	mov	[font_info], edx
	mov	edx, [eax + s_gui.screen]
	mov	[screen], edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.nb_champions]
	invoke	int_to_str, eax, str

.PLAY	cmp	dword [paused], 0
	jne	.PAUSE

	mov	eax, str1
	jmp	.THEN

.PAUSE	mov	eax, str2

.THEN	invoke	TTF_RenderText_Solid, [font_info], eax, [color]
	mov	edx, [gui]
	mov	[edx + s_gui.byte_arena], eax
	mov	[byte_arena], eax

	mov	eax, [gui]
	mov	eax, [eax + s_gui.byte_arena]
	mov	dx, word [eax + SDL_Surface.w]
	mov	eax, 0
	mov	ax, dx
	mov	edx, 0
	mov	ebx, 2
	div	ebx

	mov	edx, (WIN_X / 2)
	sub	edx, eax

	lea	eax, [position]
	mov	word [eax + SDL_Rect.x], dx
	mov	word [eax + SDL_Rect.y], 710

	lea	eax, [position]
	invoke	SDL_BlitSurface, [byte_arena], 0, [screen], eax
	_check_	.FAILB, 0, l

	invoke	TTF_RenderText_Solid, [font_info], str, [color]
	mov	edx, [gui]
	mov	[edx + s_gui.byte_arena], eax
	mov	[byte_arena], eax

	mov	word [position + SDL_Rect.x], (WIN_X - 70)
	mov	word [position + SDL_Rect.y], 725

	lea	eax, [position]
	invoke	SDL_BlitSurface, [byte_arena], 0, [screen], eax
	_check_	.FAILB, -1

	invoke	int_to_str, [cycles], str
	invoke	TTF_RenderText_Solid, [font_info], str, [color]
	mov	edx, [gui]
	mov	[edx + s_gui.byte_arena], eax
	mov	[byte_arena], eax

	mov	word [position + SDL_Rect.y], 745

	lea	eax, [position]
	invoke	SDL_BlitSurface, [byte_arena], 0, [screen], eax
	_check_	.FAILB, -1

	mov	eax, [core]
	mov	eax, [eax + s_corewar.cycle_to_die_cur]
	invoke	int_to_str, eax, str
	invoke	TTF_RenderText_Solid, [font_info], str, [color]
	mov	edx, [gui]
	mov	[edx + s_gui.byte_arena], eax
	mov	[byte_arena], eax

	mov	word [position + SDL_Rect.y], 765

	lea	eax, [position]
	invoke	SDL_BlitSurface, [byte_arena], 0, [screen], eax
	_check_	.FAILB, -1

	xor	eax, eax
	jmp	.ENDPROC

.FAILB	invoke	my_putstr, str3
.FAIL	mov	eax, -1

endproc
