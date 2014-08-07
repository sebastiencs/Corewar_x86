;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: events.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 13:40:29 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

t_events:
istruc SDL_Event
    times 20		db	0
iend

section .text

extern SDL_PollEvent
extern TTF_CloseFont
extern SDL_Quit
extern TTF_Quit

proc	manage_event, core, gui, is_pause

.LOOP	invoke	SDL_PollEvent, t_events
	cmp	eax, 0
	je	.ENDL

	cmp	byte [t_events], SDL_QUIT
	je	.EXIT

	cmp	byte [t_events + SDL_KeyboardEvent.keysim + SDL_keysym.sym], SDLK_ESCAPE
	je	.EXIT

	jmp	.PAUSE

.EXIT	mov	eax, [gui]
	invoke	TTF_CloseFont, [eax + s_gui.font]
	call	SDL_Quit
	call	TTF_Quit
	mov	eax, -1
	RET

.PAUSE	cmp	byte [t_events], SDL_KEYDOWN
	jne	.NOT

	cmp	byte [t_events + SDL_KeyboardEvent.keysim + SDL_keysym.sym], SDLK_SPACE
	jne	.NOT

	mov	eax, [is_pause]

.TEST	cmp	dword [eax], 0
	je	.ONE

	mov	dword [eax], 0
	jmp	.NOT

.ONE	mov	dword [eax], 1

.NOT	jmp	.LOOP

.ENDL	xor	eax, eax

endproc