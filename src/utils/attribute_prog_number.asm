;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: attribute_prog_number.asm
;;  Author:   chapui_s
;;  Created:   4/08/2014 21:50:58 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern check_same_prog_number
extern check_big_prog_number
extern attribute_i_to_someone

proc	attribute_prog_number, list_champion, nb_champions

	pushx	ecx, edx

	invoke	check_same_prog_number, [list_champion]
	_check_	.END, 0xFFFFFFFF

	invoke	check_big_prog_number, [list_champion], [nb_champions]
	_check_	.END, 0xFFFFFFFF

	mov	ecx, 0x1

	WHILE	ecx, le, [nb_champions]

		invoke	attribute_i_to_someone, [list_champion], ecx
		inc	ecx

	END_WHILE

	mov	eax, [list_champion]

	WHILE	eax, ne, 0x0

		mov	edx, [eax + s_champions.prog_number]
		mov	[eax + s_champions.color_gui], edx

		mov	eax, [eax + s_champions.next]

	END_WHILE

	xor	eax, eax

.END	popx	ecx, edx

endproc

; global attribute_prog_number

; attribute_prog_number:

; 	push	ebp
; 	mov	ebp, esp

; 	push	ecx
; 	push	edx

; 	mov	ecx, 1

; 	push	dword [ebp + 8]
; 	call	check_same_prog_number
; 	add	esp, 4
; 	cmp	eax, -1
; 	je	.FAIL

; 	push	dword [ebp + 12]
; 	push	dword [ebp + 8]
; 	call	check_big_prog_number
; 	add	esp, 8
; 	cmp	eax, -1
; 	je	.FAIL

; .L1	cmp	dword ecx, [ebp + 12]
; 	jg	.ENDL1

; 	push	dword ecx
; 	push	dword [ebp + 8]
; 	call	attribute_i_to_someone
; 	add	esp, 8

; 	inc	ecx
; 	jmp	.L1

; .ENDL1	mov	eax, [ebp + 8]

; .L2	cmp	eax, 0
; 	je	.ENDL2

; 	mov	edx, [eax + s_champions.prog_number]
; 	mov	[eax + s_champions.color_gui], edx

; 	mov	eax, [eax + s_champions.next]
; 	jmp	.L2

; .ENDL2	xor	eax, eax
; 	jmp	.END

; .FAIL	mov	eax, -1

; .END	pop	edx
; 	pop	ecx
; 	mov	esp, ebp
; 	pop	ebp
; 	ret
