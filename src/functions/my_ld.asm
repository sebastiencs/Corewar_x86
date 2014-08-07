;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_ld.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 20:47:47 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern is_indirect
extern is_direct
extern read_arena
extern is_good_register

proc	my_ld, core, champions, instruction

	_var_  value_to_load, pc, param0_mod, idx_mod

	pushx  edx

	mov    dword [value_to_load], 0
	mov    dword [idx_mod], IDX_MOD

	mov    eax, [instruction]
	movzx  edx, byte [eax + s_instruction.type]

.IF	invoke is_indirect, edx, 1
	cmp    eax, 1
	jne    .ELSEIF

	mov    eax, [champions]
	mov    eax, [eax + s_champions.pc]
	mov    dword [pc], eax

	mov    eax, [instruction]
	mov    eax, [eax + s_instruction.params]
	cdq
	idiv   dword [idx_mod]
	mov    dword [param0_mod], edx

	add    edx, dword [pc]

	invoke read_arena, [core], edx, 4
	mov    [value_to_load], eax
	jmp    .NEXT

.ELSEIF	invoke is_direct, edx, 1
	cmp    eax, 1
	jne    .NEXT

	mov    eax, [instruction]
	mov    eax, [eax + s_instruction.params]

	mov    [value_to_load], eax

.NEXT	mov    eax, [instruction]
	mov    eax, [eax + s_instruction.params + 4]

	invoke is_good_register, eax
	cmp    eax, 1
	jne    .NOT

	mov    eax, [instruction]
	mov    eax, [eax + s_instruction.params + 4]
	shl    eax, 2

	mov    edx, [champions]
	mov    edx, [edx + s_champions.reg]
	add    edx, eax

	mov    eax, [value_to_load]
	mov    [edx], eax

.NOT	cmp    dword [value_to_load], 0
	je     .ONE

	mov    eax, 0
	jmp    .END

.ONE	mov    eax, 1

.END	mov    edx, [champions]
	mov    dword [edx + s_champions.carry], eax

	xor    eax, eax

	popx   edx

endproc