;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: winner.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 18:18:08 (+08:00 UTC)
;;  Updated:  25/07/2014 21:19:24 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'le joueur ', 0
str2:	db '(', 0
str3:	db ') a gagne', 10, 0

section .text

extern my_putstr
extern my_putnbr

proc	winner, core

	invoke	my_putstr, str1

	mov	eax, [core]
	IF	dword [eax + s_corewar.champions], ne, 0

		mov	eax, [eax + s_corewar.champions]
		invoke	my_putnbr, [eax + s_champions.color_gui]

	ELSE

		invoke	my_putnbr, [eax + s_corewar.last_live_nb]

	ENDIF

	invoke	my_putstr, str2

	mov	eax, [core]
	IF	dword [eax + s_corewar.champions], ne, 0

		mov	eax, [eax + s_corewar.champions]
		invoke	my_putstr, [eax + s_champions.name]

	ELSE

		invoke	my_putstr, [eax + s_corewar.last_live_name]

	ENDIF

	invoke	my_putstr, str3

endproc