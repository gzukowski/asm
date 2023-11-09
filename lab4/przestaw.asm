.686
.model flat

public _przestaw

.code
_przestaw proc
push ebp
mov ebp, esp
push ebx


mov eax, [ebp + 8] ;; adres indeksu 0 w tablicy
mov ebx, [ebp + 12] ;; n - liczba elementow tablicy

dec ebx ;; liczba elementow jest o 1 wieksza niz ilsoc indeksow

mov ecx, 0 ;; iterator
petla:

	cmp ebx, ecx
	je zakoncz

	mov edx, [eax] ;; wpisanie do edx elementu tablicy

	cmp edx, [eax+4] ;; porownanie edx z nastepnym elementem
	jg zamien

	add eax, 4
	inc ecx
	jmp petla

zamien:
	mov edi, [eax+4]
	mov [eax + 4], edx
	mov [eax], edi
	add eax, 4
	inc ecx
	jmp petla


zakoncz:
	


pop ebx
pop ebp
ret
_przestaw endp
end