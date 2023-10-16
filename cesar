.686
.model flat

extern _MessageBoxW@16 : proc
extern _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
extern __read : proc
public _main


.data

magazyn db 80 dup (?)


tyt db "Elo", 00H
tytul dw 0107H, 0105H, 0142H, 00F3H, 0142H, 00H
tekst_ori dw "w","y","r","a","z","A", "w","y","r","a","z","B", "w","y","r","a","z","C", 00H

Latin2 db 0A5H, 086H, 0A9H, 088H, 0E4H, 0A2H, 098H, 0ABH, 0BEH, 00H
			;ą	;ć		;ę	;ł		;ń	;ó		;ś	;ź		;ż
Utf16  dw 0105H, 0107H,0119H,0142H,0144H,00F3H,015BH,017AH,017CH, 00h


liczba_znakow dd ?
.code

_main proc


push 80
push offset magazyn
push 0 ;;uchwyt klawiatury

call __read

mov liczba_znakow, eax

mov ecx, liczba_znakow
mov ebx, 0

petla:
	cmp ecx, 1
	je koniec
	mov dl, magazyn[ebx]
	add dl, 2
	mov magazyn[ebx], dl
dalej:
	inc ebx
	dec ecx
	jmp petla

koniec:
	nop




	push 0
	push offset tytul
	push offset magazyn
	push 0
	call _MessageBoxA@16





push 0
call _ExitProcess@4

_main endp
end
