;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_first_value.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 21:13:27 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern is_register
extern is_direct
extern is_indirect
extern read_arena
extern is_good_register

proc   get_first_value, core, champions, instruction, is_ll

       _var_	first_value, ptr, param0, idx_mod, pc, param0_mod

       pushx	edx

       mov	dword [first_value], 0
       mov	dword [idx_mod], IDX_MOD

       mov	eax, [champions]
       mov	eax, [eax + s_champions.pc]
       mov	dword [pc], eax

       mov	eax, [instruction]
       mov	eax, [eax + s_instruction.params]

       mov	[param0], eax

       cmp	dword [is_ll], 0
       jne	.NO_LL

       cdq
       idiv	dword [idx_mod]
       mov	eax, edx

.NO_LL mov	[param0_mod], eax

       mov	eax, [instruction]
       movzx	edx, byte [eax + s_instruction.type]

.IF    invoke	is_register, edx, 1
       cmp	eax, 1
       jne	.ELSI1

       invoke	is_good_register, [param0]
       cmp	eax, 1
       jne	.END

       mov	eax, [param0]
       shl	eax, 2
       mov	edx, [champions]
       mov	edx, [edx + s_champions.reg]
       add	edx, eax
       mov	eax, [edx]

       cmp	dword [is_ll], 0
       jne	.NOT2

       cdq
       idiv	dword [idx_mod]
       mov	eax, edx

.NOT2  mov	edx, [pc]
       sub	edx, 6
       add	edx, eax

       invoke	read_arena, [core], edx, 2
       mov	dword [first_value], eax
       jmp	.END

.ELSI1 invoke	is_direct, edx, 1
       cmp	eax, 1
       jne	.ELSI2

       mov	eax, [pc]
       sub	eax, 6

       cmp	dword [is_ll], 0
       jne	.NO3
       add	eax, dword [param0_mod]
       jmp	.READ
.NO3   add	eax, dword [param0]

.READ  invoke	read_arena, [core], eax, 2
       mov	dword [first_value], eax
       jmp	.END

.ELSI2 invoke	is_indirect, edx, 1
       cmp	eax, 1
       jne	.END

       mov	eax, [pc]
       sub	eax, 6
       cmp	dword [is_ll], 0
       jne	.NO4
       add	eax, dword [param0_mod]
       jmp	.READ2
.NO4   add	eax, dword [param0]

.READ2 invoke	read_arena, [core], eax, 2
       mov	dword [first_value], eax

.END   mov	eax, [first_value]

       popx	edx

endproc