;int znajdz_maks(int* tab, int n);
.686
.model flat

public _znajdz_maks

.code
_znajdz_maks proc
push ebp
mov ebp, esp
push ebx
push edi


mov eax, [ebp + 8];; adres pierwszego elementu tablicy
mov ebx, [ebp + 12] ;; liczba elementow

mov ecx, [eax] ;; ustawienie maxa na pierwszy element tablicy



petla:
	cmp ebx, 0
	je zakoncz

	cmp ecx, [eax]
	jl zmien_max


	add eax, 4
	dec ebx
	jmp petla

zmien_max:
	mov ecx, [eax]
	add eax, 4
	dec ebx
	jmp petla

zakoncz:


mov eax, ecx
pop edi
pop ebx
pop ebp
ret
_znajdz_maks endp
end