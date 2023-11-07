.686
.model flat
public _szukaj_max
.code
_szukaj_max PROC
	push ebp ; zapisanie zawartoœci EBP na stosie
	mov ebp, esp ; kopiowanie zawartoœci ESP do EBP
	mov ebx, 0 ; tu bedzie max

	mov esi, 8
	mov edi, 8

petla:
	cmp esi, 24
	je zakoncz


	mov eax, [ebp + esi]

	cmp eax, ebx
	jg zmien_max


	add esi, 4
	jmp petla


	zmien_max:
		mov ebx, eax
		mov edi, esi
		add esi, 4
		jmp petla
		




	zakoncz:
	mov eax, [ebp + edi]
	pop ebp
	ret
_szukaj_max ENDP
END