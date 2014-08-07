;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_instruction.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 00:38:26 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'code = %d type = %x p1 = %d p2 = %d p3 = %d p4 = %d', 10, 0
str2: db 'pc = %d', 10, 0
str3: db 'code = %d', 10, 0

section .text

extern get_type_and_param

proc   disp_inst, instruction1

       pushx	 eax, ecx, edx

       mov	 eax, [instruction1]

       mov	 edx, [eax + s_instruction.params + 12]
       push	 edx
       mov	 edx, [eax + s_instruction.params + 8]
       push	 edx
       mov	 edx, [eax + s_instruction.params + 4]
       push	 edx
       mov	 edx, [eax + s_instruction.params]
       push	 edx
       mov	 edx, 0
       mov	 dl, [eax + s_instruction.type]
       push	 edx
       mov	 dl, [eax + s_instruction.code]
       push	 edx
       push	 str1
       call	 printf
       add	 esp, 32

       popx	 eax, ecx, edx

endproc

proc	get_instruction, core, champions, instruction

	_var_	pc, mem_size

	pushx	eax, edx

	mov	dword [mem_size], MEM_SIZE

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]

.LOOP	cmp	eax, 0
	jge	.ENDL

	add	eax, MEM_SIZE
	jmp	.LOOP

.ENDL	cdq
	idiv	dword [mem_size]
	mov	eax, [champions]
	mov	[eax + s_champions.pc], edx

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	movzx	edx, byte [eax + edx]

	mov	eax, [instruction]
	mov	[eax + s_instruction.code], dl
	mov	dword [eax + s_instruction.params], 0
	mov	dword [eax + s_instruction.params + 4], 0
	mov	dword [eax + s_instruction.params + 8], 0
	mov	dword [eax + s_instruction.params + 12], 0

	cmp	dl, 1
	jl	.ELSE

	cmp	dl, 16
	jg	.ELSE

	invoke	get_type_and_param, [core], [champions], [instruction]
	jmp	.END

.ELSE	mov	eax, [champions]

	mov	dword [eax + s_champions.carry], 0
	mov	eax, [eax + s_champions.pc]

	inc	eax
	cdq
	idiv	dword [mem_size]
	mov	eax, [champions]
	mov	dword [eax + s_champions.pc], edx

.END	popx	eax, edx

	; pushx	eax, ebx, ecx, edx
	; invoke	disp_inst, [instruction]
	; popx	eax, ebx, ecx, edx

endproc