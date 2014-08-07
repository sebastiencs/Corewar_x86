;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_live.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 21:57:17 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'le joueur ', 0
str2:	db '(', 0
str3:	db ') est en vie', 10, 0

section .text

extern my_putstr
extern my_putnbr
extern puts

proc	im_alive, name , nb

	invoke	  my_putstr, str1
	invoke	  my_putnbr, [nb]
	invoke	  my_putstr, str2
	invoke	  my_putstr, [name]
	invoke	  my_putstr, str3

endproc

proc	my_live, core, champions, instruction

	_var_	color

	pushx	edx

	mov	eax, [champions]
	mov	eax, [eax + s_champions.color_gui]
	mov	dword [color], eax

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params]

	cmp	dword [color], eax
	jne	.END

	mov	eax, [champions]
	invoke	im_alive, [eax + s_champions.name], [color]

	mov	dword [eax + s_champions.last_live], 0
	mov	eax, [core]
	mov	edx, [color]
	mov	dword [eax + s_corewar.last_live_nb], edx
	mov	edx, [champions]
	mov	edx, [edx + s_champions.name]
	mov	dword [eax + s_corewar.last_live_name], edx
	inc	dword [eax + s_corewar.nbr_live_cur]

.END	xor	eax, eax

	popx	edx

endproc