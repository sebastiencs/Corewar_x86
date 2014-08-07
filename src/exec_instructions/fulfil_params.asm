;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: fulfil_params.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 23:54:56 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'tmp_type = %d', 10, 0

section .text

extern fulfil_dir
extern read_arena

proc   fulfil_param, core, champion, instruction

       _var_	decal, tmp_type, other, param_ptr, mem_size

       pushx	eax, ecx, edx

       mov	dword [mem_size], MEM_SIZE
       mov	dword [other], 0
       mov	dword [tmp_type], 0

       mov	eax, [instruction]
       movzx	edx, byte [eax + s_instruction.type]
       shr	dl, 2
       shl	dl, 2
       mov	byte [tmp_type], dl

       mov	eax, [champion]
       mov	eax, [eax + s_champions.pc]
       add	eax, 2
       mov	[decal], eax

       mov	eax, [instruction]
       lea	eax, [eax + s_instruction.params]
       mov	[param_ptr], eax

       xor	ecx, ecx

.LOOP  movzx	eax, byte [tmp_type]
       and	al, 0b11000000
       test	al, al
       jz	.ENDL

       movzx	eax, byte [tmp_type]
       shr	al, 6
       mov	byte [other], al

       IF	byte [other], e, 1

       		invoke	read_arena, [core], [decal], 1
		mov	edx, [param_ptr]
		mov	[edx + (ecx * 4)], eax
		inc	dword [decal]

       ELSEIF	byte [other], e, 0b10

       		lea	eax, [decal]
       		invoke	fulfil_dir, [core], [champion], [instruction], eax
		mov	edx, [param_ptr]
		mov	[edx + (ecx * 4)], eax

       ELSE

		invoke	read_arena, [core], [decal], 2
		mov	edx, [param_ptr]
		mov	[edx + (ecx * 4)], eax
		add	dword [decal], 2

       ENDIF

       shl	byte [tmp_type], 2
       inc	ecx
       jmp	.LOOP

.ENDL  mov	eax, [decal]
       cdq
       idiv	dword [mem_size]
       mov	eax, [champion]
       mov	[eax + s_champions.pc], edx

       popx	eax, ecx, edx

endproc