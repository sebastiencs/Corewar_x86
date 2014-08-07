;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;  Filename: disp_players.asm
;;  Author:   chapui_s
;;  Created:  18/07/2014 18:51:56 (+08:00 UTC)
;;  Updated:  19/07/2014 17:52:51 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: SDL_BlitSurface', 10, 0

section .text

extern SDL_BlitSurface
extern my_putstr

%define position ebp - 8

proc	disp_players, gui

	sub	esp, 8

	pushx	edx, ebx, ecx

	lea	eax, [position]
	mov	word [eax + SDL_Rect.x], 100
	mov	word [eax + SDL_Rect.y], 730

	mov	ecx, 0

.LOOP	mov	edx, [gui]
	mov	eax, [gui]
	add	edx, s_gui.players
	add	edx, ecx
	cmp	dword [edx], 0
	je	.ENDL

	pushx	ecx
	lea	ebx, [position]
	invoke	SDL_BlitSurface, [edx], 0, [eax + s_gui.screen], ebx
	_check_	.FAIL, -1
	popx	ecx

	lea	eax, [position]
	add	word [eax + SDL_Rect.y], 15

	add	ecx, 4
	jmp	.LOOP

.FAIL	invoke	my_putstr, str1
	mov	eax, -1
	jmp	.ENDPROC

.ENDL	xor	eax, eax
	popx	edx, ebx, ecx

endproc