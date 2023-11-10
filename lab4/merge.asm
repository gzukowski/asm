.686
.model flat

public _merge
.DATA
	wynik dd 8 dup (?)
	dwa dd 2
	wielkosc dd ?
	wielkosc2 dd ?

.code
_merge proc
push ebp
mov ebp, esp
push ebx
push edi

mov eax, [ebp + 16] ;; n - wielkosc 1 tablicy

mov wielkosc, eax
mov wielkosc2, eax

mul dwa

cmp eax, 8
ja zakoncz_nullem

mov ebx, [ebp + 8] ;; w ebx adres pierwszej tablicy


mov edi, 0


petla1:
	cmp wielkosc, 0
	je zakoncz_ptl1


	mov ecx, [ebx + edi]
	mov wynik[edi], ecx

	add edi, 4
	sub wielkosc, 1

	jmp petla1


zakoncz_ptl1:


mov ebx, [ebp + 12] 
mov esi, edi
mov edi, 0
petla2:
	cmp wielkosc2, 0
	je zakoncz_ptl2


	mov ecx, [ebx + edi]
	mov wynik[esi], ecx

	add esi, 4
	add edi, 4q
	sub wielkosc2, 1

	jmp petla2



zakoncz_nullem:
	mov eax, 0

zakoncz_ptl2:
mov eax, offset wynik

pop edi
pop ebx
pop ebp
ret
_merge endp
end