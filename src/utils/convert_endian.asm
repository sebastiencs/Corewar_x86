
section .data

global little_to_big_endian

little_to_big_endian:

	push	ebp
	mov	ebp, esp

	mov	eax, [ebp + 8]
	bswap	eax

	mov	esp, ebp
	pop	ebp
	ret
