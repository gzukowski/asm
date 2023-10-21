.686
.model flat


extern __read : proc
extern __write : proc
EXTERN _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
public _main


.data 
	tytul db "Tytul", 0H
	znaki db 12 dup (?)


.code
wyswietl_EAX PROC
pusha ;; zapamietaj wartosci rejestrow na stosie


petla:
	cmp edi, 0
	je koniec


	div ebx ;; dzielimy liczbe rozstawioną na przedziale  edx:eax

	;; reszta zaladowana do edx
	;; iloraz zaladowany do eax
	
	add dl, 30H
	mov znaki[edi], dl
	mov dx, 0
	dec edi


	cmp eax, 0   ;; sprawdzamy czy iloraz jest rowny 0, jesli tak to oznacza ze konwersja sie zakonczyla
	je wypelnij


	jmp petla

wypelnij:
	mov znaki[edi], ' '
	dec edi
	cmp edi, 0
	je koniec

	jmp wypelnij

koniec:
	mov znaki[0], 10
	mov znaki[11], 00H


push 12
push offset znaki
push 1

call __write

add esp, 12

mov edi, 0

wyczysc:
	cmp edi, 11
	je koniec2

	mov znaki[edi], ' '
	inc edi
	jmp wyczysc

koniec2:
	nop
popa ;; odbierz wartosci rejestrow ze stosu
ret
wyswietl_EAX ENDP

wzor PROC
pusha ;; zapamietaj wartosci rejestrow na stosie

;; wzor na ten ciag 1/2(n^2) + 1/2(n) + 1

mov esi, eax
mul esi   ;; n^2


call wyswietl_EAX

popa ;; odbierz wartosci rejestrow ze stosu
ret
wzor ENDP


_main proc


mov eax, 0  ;; liczba na 64 bit
mov edx, 0	  ;; liczba na 64 bit


mov ebx, 10   ;; dzielnik 

mov edi, 10 ;; maksymalna ilosc cyfr przy rejestrze 32 bitowym sluzy jako indeksowanie





petla3:
	cmp eax, 51
	je koniec4
	call wzor
	inc eax
	jmp petla3
koniec4:
	nop

push 0
call _ExitProcess@4
_main endp
end
