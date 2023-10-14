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

	Latin2 db 0A5H,  086H,  0A9H,  088H,  0E4H,  0A2H,  098H,  0ABH,  0BEH, 0A4H,  086H,  0A8H,  09DH,  0E3H,  0E0H,  097H,  08DH,  0BDH,   00H
				;ą	  ;ć	;ę	    ;ł	   ;ń	  ;ó	;ś	    ;ź	   ;ż
	Utf16  dw 0104H, 0106H, 0118H, 0141H, 0143H, 00D3H, 015AH, 0179H, 017BH,0104H, 0106H, 0118H, 0141H, 0143H, 00D3H, 015AH, 0179H, 017BH,  00h

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
mov ecx ,eax
mov esi, 0 ;; index petli


mov eax, 18 ;;ilosc spejclanych znakow
mov edi, 0 ;; index petli



petla:
	cmp ecx, 1
	je koniec
	cmp magazyn[esi], 'a'
	jb rozszerz
	cmp magazyn[esi], 'z'
	ja wstaw_spec

	jmp rozszerz
dalej_petla:
	inc esi
	dec ecx
	jmp petla


wstaw_spec:
	cmp eax, 0
	je dalej_petla

	mov dl, Latin2[edi]
	cmp magazyn[esi], dl
	jne dalej_wstaw_spec
	
	mov dx, Utf16[edi*2]
	mov magazyn16[esi*2], dx
	mov eax, 18
	mov edi, 0
	jmp dalej_petla
dalej_wstaw_spec:
	inc edi
	dec eax
	jmp wstaw_spec

rozszerz:
	mov dl, magazyn[esi]
	sub dl, 20H
	movzx dx, dl
	mov magazyn16[esi*2], dx
	jmp dalej_petla

cmp ecx, 0
je koniec



koniec:
	nop

push 0 ;;mb_ok
push offset tytul_uni
push offset magazyn16
push 0 ; uchwyt

call _MessageBoxW@16


push 0
call _ExitProcess@4
_main endp

end
