.686
.model flat

extern _MessageBoxW@16 : proc
extern _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
extern __read: proc

public _main

.data
	tekst db "Tekst", 00H
	tytul db "Tytul", 00h

	tytul_uni dw "T", "y", "t", "u", "l", 00H

	Latin2 db 0A5H,  086H,  0A9H,  088H,  0E4H,  0A2H,  098H,  0ABH,  0BEH, 00H
				;ą	  ;ć	;ę	    ;ł	   ;ń	  ;ó	;ś	    ;ź	   ;ż
	Utf16  dw 0105H, 0107H, 0119H, 0142H, 0144H, 00F3H, 015BH, 017AH, 017CH, 00h

	magazyn16 dw 80 dup (?)
	buffor dd ?

	magazyn db 80 dup (?)
	liczba_znakow dd ?



.code 

_main PROC


;; wysw msgbox latin2
push 0 ;; mb_ok
push offset tytul
push offset tekst
push 0 ;;uchwyt


call _MessageBoxA@16

;; zczytywanie tekstu do magazynu

push 80 ;; maks dlugosc
push offset magazyn
push 0 ;; urzadzenie klawiatura

call __read



;; read wrzuca do eax ilosc zczytanych znakow
mov liczba_znakow, eax

mov ecx, liczba_znakow  ;; maks petli1
mov esi, 0 ;; indeksowanie petli1
mov edi, 0 ;; indeksowanei petli2
mov eax, 9 ;; maks petli2


petla:
	cmp magazyn[esi], 'z'
	ja petla_utf

	mov dl, magazyn[esi]
	movzx dx, dl
	mov magazyn16[esi*2], dx

dalej_petla:
	inc esi
	loop petla

cmp ecx, 0
je koniec

petla_utf:
	cmp eax, 0			 ;;koniec petli
	je dalej_petla

	mov dl, Latin2[edi]
	cmp magazyn[esi], dl
	jne dalej_petla_utf

	mov dx, Utf16[edi*2]
	mov magazyn16[2*esi], dx
	mov edi, 0
	mov eax, 9
	jmp dalej_petla

dalej_petla_utf:
	inc edi
	dec eax
	jmp petla_utf


koniec:
	nop


;; wyswietlanie utf16

push 0 ;;mb_ok
push offset tytul_uni
push offset magazyn16
push 0 ; uchwyt

call _MessageBoxW@16


push 0
call _ExitProcess@4
_main endp

end
