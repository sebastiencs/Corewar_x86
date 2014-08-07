;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_add.asm
;;  Author:   chapui_s
;;  Created:  20/07/2014 23:30:24 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'ADD %d + %d = %d', 10, 0

section .text

extern is_good_register

extern printf

proc	 my_add, core, champions, instruction

	 _var_	value1, value2, param0, param1, param2

	 pushx	edx

	 mov	dword [value1], 0
	 mov	dword [value2], 0

	 mov	eax, [instruction]
	 add	eax, s_instruction.params

	 mov	edx, [eax]
	 mov	[param0], edx
	 mov	edx, [eax + 4]
	 mov	[param1], edx
	 mov	edx, [eax + 8]
	 mov	[param2], edx

.1	 invoke	is_good_register, [param0]
	 cmp	eax, 1
	 jne	.2

	 mov	eax, [param0]
	 shl	eax, 2
	 mov	edx, [champions]
	 mov	edx, [edx + s_champions.reg]
	 add	edx, eax
	 mov	edx, [edx]
	 mov	[value1], edx

.2	 invoke	is_good_register, [param1]
	 cmp	eax, 1
	 jne	.3

	 mov	eax, [param1]
	 shl	eax, 2
	 mov	edx, [champions]
	 mov	edx, [edx + s_champions.reg]
	 add	edx, eax
	 mov	edx, [edx]
	 mov	[value2], edx

.3	 invoke	is_good_register, [param2]
	 cmp	eax, 1
	 jne	.END

	 mov	eax, [value1]
	 add	eax, [value2]

	 ; pushx	eax, ebx, ecx, edx
	 ; invoke	printf, str1, [value1], [value2], eax
	 ; popx	eax, ebx, ecx, edx


	 mov	[value1], eax

	 mov	eax, [param2]
	 shl	eax, 2
	 mov	edx, [champions]
	 mov	edx, [edx + s_champions.reg]
	 add	edx, eax
	 mov	eax, [value1]
	 mov	[edx], eax

.END	 mov	eax, [champions]
	 add	eax, s_champions.carry

	 cmp	dword [value1], 0
	 je	.ONE

	 mov	dword [eax], 0
	 xor	eax, eax
	 popx	edx
	 jmp	.endproc

.ONE	 mov	dword [eax], 1
	 xor	eax, eax
	 popx	edx

endproc