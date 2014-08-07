;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: is_register.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 23:27:20 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

proc	 is_register, octet_type, num_param

	 mov	eax, 1

.LOOP	 cmp	eax, [num_param]
	 jge	.ENDL

	 shl	dword [octet_type], 2
	 inc	eax
	 jmp	.LOOP

.ENDL	 and	dword [octet_type], 0b11000000
	 cmp	dword [octet_type], 0b01000000
	 je	.ONE

	 xor	eax, eax
	 jmp	.endproc

.ONE	 mov	eax, 1

endproc