.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC 
extern _MessageBoxA@16 : PROC



public _main

.data



	dekoder db  "0123456789ABCDEF"
	magazyn db 12 dup (?)


.code

wczytaj_do_eax proc
push ebx
push ecx
push edx
push edi
push esi

push 12
push offset magazyn
push 0   ;;; klawiataura to 0 !!!!!!!!!!!!
call __read

add esp, 12


;; konwersja z tablicy znakow na reprezentacje liczbowa do rejestru eax
mov eax, 0
mov edx, 0
mov ecx, 0
mov ebx, 0
mov esi, 10 ;; mnoznik 
mov edi, 0 ;; indeks petli

petla:
		mov cl, magazyn[edi]
	cmp cl, 10 ;; czy jest enterem
	je byl_enter


	mul esi
	sub cl, 30H
	movzx ebx, cl
	add eax, ebx
	inc edi
	jmp petla

byl_enter:
	nop

pop ebx
pop ecx
pop edx
pop edi
pop esi
ret
wczytaj_do_eax endp

wyswietl_eax_hex proc
pusha
;; stos "rosnie" ujemnie, przez co aby zarezerwowac odpowiednia ilosc miejsca na przechowanie liczby
;; nalezy zarezerwowac mu w naszym przypadku 12 bajtow, mozna to zrobic odejmujac od niego liczbe 12

sub esp, 12
;; nastepnie przechowac nalezy adres zarezerwowanego obszaru pamieci
mov edi, esp


mov ecx, 0 ;; licznik cyfr znaczacych
mov esi, 1 ;; indeksowanie po stosie
konwersja:
	cmp esi, 9 ;; maks 8 cyfr w szesnastkowym systemie
	je koniec_eax_hex


	rol eax, 4 ;; przesuniecie cykliczne o 4 bity, co oznacza ze 4 bity najstarsze przejda na miejsce 4 najmlodszych bitow
	mov ebx, eax ;; przechowanie wartosaci z eax

	and eax, 0000000FH ;; wyzerowanie wszystkich bitow poza 4 najmlodszymi
	
	mov dl, dekoder[eax]

	cmp dl, '0'
	jz sprawdz_zero

	jmp licznik_znaczacych

	konwersja_warunek:
		mov [edi][esi], dl
		inc esi ;; zwiekszenie indeksu
		mov eax, ebx ;; zwrocenie wartosci do rejestru eax z poczatku petli

	jmp konwersja


sprawdz_zero:
	cmp ecx, 0
	je wstaw_spacje

	jmp wstaw_zero

wstaw_zero:
	mov dl, '0'
	jmp konwersja_warunek

wstaw_spacje:
	mov dl, ' '
	jmp konwersja_warunek

licznik_znaczacych:
	cmp ecx, 1
	je konwersja_warunek

	inc ecx
	jmp konwersja_warunek
koniec_eax_hex:
	mov byte ptr [edi][0], 10
	mov byte ptr [edi][9], 0



push 10
push edi
push 1

call __write

add esp, 24
popa
ret
wyswietl_eax_hex endp


_main proc


call wczytaj_do_eax

call wyswietl_eax_hex

push 0
call _ExitProcess@4

_main endp
end
