;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: fulfil_dir.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 23:40:11 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern read_arena
extern is_special

proc   fulfil_dir, core, champion, instruction, decal

       _var_	to_return, code, decal_int

       pushx	edx

       mov	dword [to_return], 0
       mov	eax, [instruction]
       movzx	edx, byte [eax + s_instruction.code]
       mov	[code], edx

       mov	eax, [decal]
       mov	eax, [eax]
       mov	[decal_int], eax

.IF    cmp	edx, LDI
       je	.ELSE

       cmp	edx, STI
       je	.ELSE

       cmp	edx, LLDI
       je	.ELSE

       invoke	read_arena, [core], [decal_int], 4
       mov	[to_return], eax

       mov	eax, [decal_int]
       add	eax, 4
       mov	edx, [decal]
       mov	[edx], eax
       jmp	.END

.ELSE  invoke	is_special, [champion], [instruction], [decal_int]
.IF2   cmp	eax, 1
       jne	.ELSE2

       invoke	read_arena, [core], [decal_int], 2
       mov	[to_return], eax

       mov	eax, [decal_int]
       add	eax, 2
       mov	edx, [decal]
       mov	[edx], eax
       jmp	.END

.ELSE2 invoke	read_arena, [core], [decal_int], 4
       mov	[to_return], eax

       mov	eax, [decal_int]
       add	eax, 4
       mov	edx, [decal]
       mov	[edx], eax

.END   mov	eax, [to_return]

       popx	edx

endproc