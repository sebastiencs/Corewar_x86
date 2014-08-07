;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_strcmp.asm
;;  Author:   chapui_s
;;  Created:   5/08/2014 02:01:42 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

proc	my_strcmp, s1, s2

	pushx	esi, edi
        pushfd

        xor     eax, eax
        mov     esi, [s1]
        mov     edi, [s2]
        cld

.LOOP   cmpsb
        jnz     .DIFF

        cmp     byte [esi - 1], 0
        jne     .LOOP
        jmp     .END

.DIFF   movzx   eax, byte [esi - 1]
        sub     al, byte [edi - 1]
        cbw
        cwde

.END	popfd
	popx	esi, edi

endproc
