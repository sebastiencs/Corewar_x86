;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: usage.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 02:14:40 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .data

msg:	db 'usage: ./corewar [-dump nbr_cycle] [[-n prog_number] [-a load_address] prog_name] ...', 10, 0

section .text

extern	my_putstr

proc	usage

	invoke	my_putstr, msg

	mov	eax, -1

endproc