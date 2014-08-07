;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_two_def.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 23:44:45 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

extern	mem_size

section .text

extern	swap_int

proc	attribute_two_def, champions, pa, nb

	_var_	p0, p1

	pushx	eax, ebx, ecx, edx

	mov	eax, [champions]
	mov	ecx, 0x1

	WHILE	eax, ne, 0x0

		IF	dword [eax + s_champions.load_address], ne, 0x0

			mov	edx, [eax + s_champions.load_address]
			mov	[p1 + (ecx * 0x4)], edx		; bascule entre p0 et p1
			dec	ecx

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	mov	eax, [p1]

	IF	eax, l, [p0]

		lea	eax, [p0]
		lea	edx, [p1]
		invoke	swap_int, eax, edx

	ENDIF

	mov	eax, [p1]
	sub	eax, [p0]
	IF	eax, g, MEM_SIZE / 0x2

		cdq
		idiv	dword [nb]
		add	eax, [p0]

	ELSE

		mov	edx, MEM_SIZE
		sub	edx, eax
		mov	eax, edx
		cdq
		idiv	dword [nb]
		add	eax, [p1]

	ENDIF

	mov	[pa], eax

	mov	eax, [champions]

	WHILE	eax, ne, 0x0

		mov  edx, [pa]

		IF	edx, l, 0x0

			add	dword [pa], MEM_SIZE

		ENDIF

		IF	dword [eax + s_champions.load_address], e, 0x0

			push	eax
			mov	eax, [pa]
			cdq
			idiv	dword [mem_size]
			pop	eax
			mov	[eax + s_champions.load_address], edx

			mov	edx, [pa]

			mov	ebx, [p1]
			sub	ebx, [p0]

			IF	ebx, l, (MEM_SIZE / 0x2)

				sub	edx, [p1]

			ENDIF

			IF	ebx, ge, (MEM_SIZE / 0x2)

				sub	edx, [p0]

			ENDIF

			add	[pa], edx

		ENDIF

		mov	eax, [eax + s_champions.next]

	END_WHILE

	popx	eax, ebx, ecx, edx

endproc
