;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: copy_reg.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 20:17:12 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1:	db 'error: malloc', 10, 0

section .text

extern malloc
extern my_putstr

proc	copy_reg, father

	_var_	new

	pushx	ebx, ecx, edx

	mov	eax, REG_NUMBER
	inc	eax
	shl	eax, 2
	invoke	malloc, eax
	_check_	.FAIL, 0
	mov	[new], eax

	mov	ecx, 1

	mov	eax, [new]
	mov	edx, [father]

.LOOP	cmp	ecx, REG_NUMBER
	jg	.ENDL

	mov	ebx, [edx]
	mov	[eax], ebx

	add	eax, 4
	add	edx, 4
	inc	ecx
	jmp	.LOOP

.ENDL	mov	eax, [new]
	popx	ebx, ecx, edx
	jmp	.endproc

.FAIL	invoke	my_putstr, str1
	popx	ebx, ecx, edx
	xor	eax, eax

endproc