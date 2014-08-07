;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: exec_instructions.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 12:36:59 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

instruction:
istruc s_instruction
 times 10	db	10
iend

str1: db '&instruction >> %x <<', 10, 0

section .text

extern get_instruction
extern exec_function
extern get_cycle_to_wait

proc	exec_instructions, core, champions

	_var_	tmp

	pushx	edx

	mov	eax, [champions]
	mov	[tmp], eax

.LOOP	cmp	dword [tmp], 0
	je	.ENDL

	mov	eax, [tmp]
	mov	eax, [eax + s_champions.cycle_to_wait]

.TEST	IF	eax, le, 1

		lea	eax, [instruction]
		invoke	get_instruction, [core], [tmp], eax

		lea	eax, [instruction]
		invoke	exec_function, [core], [tmp], eax
		_check_	.FAIL, -1

		invoke	get_cycle_to_wait, [core], [tmp]

	ELSE

		mov	eax, [tmp]
		dec	dword [eax + s_champions.cycle_to_wait]

	ENDIF

	mov	eax, [tmp]
	inc	dword [eax + s_champions.last_live]

	mov	edx, [eax + s_champions.next]
	cmp	eax, edx
	jz	.ENDL

	mov	eax, [tmp]
	mov	eax, [eax + s_champions.next]
	mov	dword [tmp], eax
	jmp	.LOOP


.ENDL	xor	eax, eax

.END	popx	edx
	RET

.FAIL	mov	eax, -1
	jmp	.END

endproc