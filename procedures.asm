.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC 
extern _MessageBoxA@16 : PROC



public _main

.data

	magazyn db 12 dup (?)
	znaki db 12 dup (?)
	mnoznik dd 10



.code

wyswietl_eax proc
pusha


konwersja:
	cmp edi, 0
	je koniec

	;; dzielna w przypadku dzielnika 32-bitowego, znajduje sie na obszarze edx:eax, nastepnie iloraz trafia do eax, a reszta do edx

	mov edx, 0 ;; zerowanie starszej czesci dzielnej

	div ebx ;; ebx = 10, nasz dzielnik w systemie dziesiatkowym
	
	add dl, 30H
	
	mov znaki[edi], dl
	dec edi


	cmp eax, 0 ;; iloraz byl zero, co oznacza ze ostatnia cyfra zostala zczytana
	je koniec 

	jmp konwersja




koniec:
	mov znaki[0], 10
	mov znaki[11], 0H

push 12
push offset znaki
push 1

call __write

add esp, 12


popa
ret
wyswietl_eax endp


wczytaj_do_eax proc
push ebx
push ecx
push edx
push esi
push edi

mov ecx, 0 ;; wyzerowanie sumowania

mov eax, 0 
mov edi, 0
mov esi, 10
petla:
	mov bl, magazyn[edi] ;; zczytaj kolejna cyfre z magazynu
	cmp bl, 10 ;; porownaj z enterem, i zakoncz jest to enter
	je zakoncz


	mov edx, 0   ;; wyzerowanie starszej czesci
	mov eax, ecx	;; przeniesienie aktualnej sumy do licznika
	mul esi			;; przemnoz edx:eax przez esi = 10
	mov ecx, eax



	sub bl, 30H
	movzx ebx, bl ;; rozszerz  bl do 32 bitow
	add ecx, ebx ;; dodaj do aktualnej sumy
	;;add eax, ebx


	
	inc edi ;; inkrementacja indeksu 

	jmp petla
	
	
	
zakoncz:
	nop
	mov eax, ecx


pop ebx
pop ecx
pop edx
pop esi
pop edi
ret
wczytaj_do_eax endp

_main proc

push 12
push offset magazyn
push 0

call __read

add esp, 12 



mov edi, 10 ;; indeksowanie od 10
mov ebx, 10 ;; dzielnik / mnoznik



call wczytaj_do_eax



;; kwadrat eax 

mov edx, 0

mul eax


call wyswietl_eax

push 0
call _ExitProcess@4
_main endp
end


