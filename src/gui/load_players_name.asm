
%include "corewar.inc"

section .data

str1:	db 'error: TTF_RenderText', 10, 0

section .text

extern get_color_champions
extern TTF_RenderText_Solid
extern my_putstr
extern my_strlen

global load_players_name

load_players_name:

	push	ebp
	mov	ebp, esp

	sub	esp, 12
	; [ebp - 4]  cur
	; [ebp - 8]  i
	; [ebp - 12] *tmp
	push	ebx
	push	edx

	mov	dword [ebp - 8], 0
	mov	dword [ebp - 4], 1
	mov	ebx, [ebp + 8]
	mov	ebx, [ebx + s_corewar.champions]

.LOOP	cmp	ebx, 0
	je	.ENDL

.IF1	mov	edx, [ebx + s_champions.prog_number]
	cmp	edx, [ebp - 4]
	jne	.ELSE1

	mov	edx, [ebx + s_champions.color_gui]
	push	edx
	push	dword [ebp + 12]
	call	get_color_champions
	add	esp, 8

.IF2	mov	edx, [ebx + s_champions.name]
	push	dword edx
	call	my_strlen
	add	esp, 4
	cmp	eax, 0
	jle	.ELSE2

	push	ebx
	mov	edx, [ebp + 12]
	mov	edx, [edx + s_gui.my_color]
	push	dword edx
	mov	edx, [ebx + s_champions.name]
	push	dword edx
	mov	edx, [ebp + 12]
	mov	edx, [edx + s_gui.font_info]
	push	dword edx
	call	TTF_RenderText_Solid
	add	esp, 12
	cmp	eax, 0
	je	.FAIL
	pop	ebx

	mov	edx, [ebp + 12]
	add	edx, s_gui.players
	; mov	edx, [edx + s_gui.players]
	add	edx, dword [ebp - 8]
	mov	[edx], eax
	add	dword [ebp - 8], 4

.ELSE2	inc	dword [ebp - 4]
	mov	ebx, [ebp + 8]
	mov	ebx, [ebx + s_corewar.champions]
	jmp	.LOOP

.ELSE1	mov	ebx, [ebx + s_champions.next]
	jmp	.LOOP

.FAIL	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.ENDL	mov	edx, [ebp + 12]
	add	edx, s_gui.players
	add	edx, [ebp - 8]
	mov	dword [edx], 0
	xor	eax, eax

.END	pop	edx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret
