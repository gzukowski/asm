.686
.model flat

extern _MessageBoxW@16 : proc
extern _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
extern __read : proc
extern __write : proc
public _main


.data

magazyn db 80 dup (0)
bufor db 80 dup (0)

liczba_znakow dd ?
.code 
_main proc

push 80
push offset magazyn
push offset 0 ;; uchwyt klawiatury

call __read

mov liczba_znakow, eax


mov ecx, liczba_znakow
mov esi, 0
mov edi, 0 ;; indeks w buforze


petla:
	cmp ecx, 1
	je koniec

	cmp magazyn[esi], '\'
	je porownaj
	
	mov dl, magazyn[esi]
	mov bufor[edi], dl
dalej:
	inc esi
	dec ecx
	inc edi
	jmp petla

porownaj:
	mov edx, esi
	inc esi
	dec ecx
	cmp ecx, 1
	je koniec
	cmp magazyn[esi], 't'
	jne omin
	mov bufor[edx], ' '
	mov bufor[esi], ' '
	mov bufor[esi+1], ' '
	mov bufor[esi+2], ' '
	add edi, 3
	jmp dalej

omin:
	mov dl, magazyn[edx]
	mov bufor[edi], dl
	inc edi
	mov dl, magazyn[esi]
	mov bufor[edi], dl
	cmp bufor[edi], dl
	jmp dalej
	

	




koniec:
nop	


push 80
push offset bufor
push 1

call __write

push 0
call _ExitProcess@4

_main endp
end
