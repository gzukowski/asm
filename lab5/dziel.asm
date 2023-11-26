.686
.model flat
.xmm

public _dziel
.data

.code
_dziel proc
push ebp
mov ebp, esp
push ebx

mov eax, [ebp+8]


mov ebx, [ebp +12]

mov ecx, ebp
add ecx, 16




petla:
	cmp ebx, 0
	je zakoncz


	movups xmm0, [eax]
	movups xmm1, [ecx]
	shufps xmm1, xmm1, 0

	divps xmm0, xmm1
	movups [eax], xmm0

	dec ebx
	add eax, 16
	JMP petla



zakoncz:


pop ebx
pop ebp
ret
_dziel endp
end