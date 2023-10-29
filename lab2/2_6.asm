.686
.model flat


extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern _MessageBoxA@16 : PROC
extern __read : PROC
extern __write : PROC
public _main

.data

magazyn db 80 dup (?)
liczba_znakow dd ?

tytul_uni dw "T", "o", " ", "t", "y", "t", "u", 0142H, 00H
tekst_uni dw "T","e","k","s","t", 00H


tytul db "Tytul", 0
tekst db 10, "mas", 0B3H,0

Latin2 db 0A5H, 086H, 0A9H, 088H, 00H
		   ;ą   ;ć    ;ę    ;ł
Wi_1250 db 0B9H, 0E6H, 0EAH, 0B3H, 00H

.code
_main PROC

;; wyswietlanie komunikatu na poczatku w unicode
push 0 ;; mb_ok
push offset tytul_uni
push offset tekst_uni
push 0

call _MessageBoxW@16

add esp, 12

;; wyswietlanie komunikatu na poczatku

push 0 ;;mb_ok
push offset tytul
push offset tekst
push 0

call _MessageBoxA@16

add esp, 12

;; zczytywanie wartosci wpisanej w konsole
push 80
push offset magazyn
push 0 ; 0 to numer urzadzenia klawiatura

call __read

add esp, 12



mov liczba_znakow, eax


;; wypisanie do konsoli ilosci znakow

push liczba_znakow
push offset magazyn
push 1 ; 1 to numer urzadzenia monitor

call __write

add esp, 12



;; rozpoczynanie petli

;; ecx pelni licznik petli

mov ecx, liczba_znakow ;; ilosc przejsc petli
mov ebx, 0 ;; indeksowanie


ptl:
	cmp magazyn[ebx], 0A5H
	je sprawdz0
	cmp magazyn[ebx], 086H
	je sprawdz1
	cmp magazyn[ebx], 0A9H
	je sprawdz2
	cmp magazyn[ebx], 088H
	je sprawdz3

	jmp dalej

	
sprawdz0:
	mov magazyn[ebx], 0B9H
	jmp dalej
sprawdz1:
	mov magazyn[ebx], 0E6H
	jmp dalej
sprawdz2:
	mov magazyn[ebx], 0EAH
	jmp dalej
sprawdz3:
	mov magazyn[ebx], 0B3H
	jmp dalej
	

dalej:
	inc ebx
	loop ptl



push 0
push offset tytul
push offset magazyn
push 0 ; 1 to numer urzadzenia monitor

call _MessageBoxA@16

call _ExitProcess@4
_main endp
END
