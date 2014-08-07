;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: SDL_definitions.inc
;;  Author:   chapui_s
;;  Created:  25/07/2014 21:40:23 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%ifndef SDL_DEFINITIONS_INC_
 %define SDL_DEFINITIONS_INC_

struc		SDL_keysym
 .scancode:		resb	1
 .unused:		resb	3			; alignb	4	; Uint8
 .sym:			resd	1	; SDLKey
 .mod:			resd	1	; SDLMod
 .unicode:		resw	1
 			alignb	2	; Uint16
endstruc

struc		SDL_KeyboardEvent
 .type:			resb	1	; Uint8
 .which:		resb	1	; Uint8
 .state:		resb	1	; Uint8
 .unused:		resb	1
 .keysim:		resb	16	; SDL_Keysim
endstruc

struc		SDL_Event
			resb	20	; Union de tout plein de trucs (SDL_Event.h)
endstruc

 %define	SDL_KEYDOWN	(2)
 %define	SDL_QUIT	(12)
 %define	SDLK_ESCAPE	(27)
 %define	SDLK_SPACE	(32)

%endif