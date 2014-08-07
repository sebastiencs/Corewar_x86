
section .data

base:	db '0123456789ABCDEF', 0

section .text

global hex_to_str

hex_to_str:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	edx, [ebp + 12]

	mov	eax, 0
	mov	al, byte [ebp + 8]
	shr	al, 4

	mov	al, byte [base + eax]
	mov	byte [edx], al

	mov	eax, 0
	mov	al, byte [ebp + 8]
	and	al, 0x0f

	mov	al, byte [base + eax]
	mov	byte [edx + 1], al

	mov	byte [edx + 2], 0

	mov	eax, edx
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
