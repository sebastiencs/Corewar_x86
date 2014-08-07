;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_putstr.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 15:45:25 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern my_strlen

proc	my_putstr, string

	pushx	eax, ebx, ecx, edx

	mov	edx, 4
	mov	ebx, 1
	mov	ecx, [string]
	invoke	my_strlen, [string]
	xchg	edx, eax
	int	0x80

	popx	eax, ebx, ecx, edx

endproc