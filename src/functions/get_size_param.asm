;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_size_param.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 19:33:26 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

proc	get_size_param, type

	_var_	size

	mov	dword [size], 0

.LOOP	movzx	eax, byte [type]
	and	eax, 0b11000000
	cmp	eax, 0
	je	.ENDL

.1	cmp	eax, 1
	jne	.2

	inc	dword [size]

.2	cmp	eax, 0b10
	jne	.3

	add	dword [size], 4
	jmp	.NEXT

.3	add	dword [size], 2

.NEXT	shl	byte [type], 2
	jmp	.LOOP

.ENDL	mov	eax, [size]
	inc	eax

endproc