.686
.model flat

extern _MessageBoxW@16 : proc
extern _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
extern __read : proc
public _main


.data

magazyn db 80 dup (?)


tytul dw 0107H, 0105H, 0142H, 00F3H, 0142H, 00H
tekst_ori dw "w","y","r","a","z","A", "w","y","r","a","z","B", "w","y","r","a","z","C", 00H

Latin2 db 0A5H, 086H, 0A9H, 088H, 0E4H, 0A2H, 098H, 0ABH, 0BEH, 00H
			;ą	;ć		;ę	;ł		;ń	;ó		;ś	;ź		;ż
Utf16  dw 0105H, 0107H,0119H,0142H,0144H,00F3H,015BH,017AH,017CH, 00h


w1 dw  32 dup (?)
w2 dw  32 dup (?)
w3 dw  32 dup (?)

magazyn16 dw 80 dup (?)


liczba_z1 dd 6
liczba_z2 dd 6
liczba_z3 dd 6

.code
_main PROC

push 0
	push offset tytul
	push offset tekst_ori
	push 0

	call _MessageBoxW@16

mov ecx, liczba_z1
mov esi, 0

petla:
	cmp ecx, 0
	je koniec1

	mov dx, tekst_ori[esi*2]
	mov w1[esi*2], dx
dalej:
	inc esi
	dec ecx
	jmp petla

koniec1:
	nop


mov ecx, liczba_z3
mov esi, 0

petla2:
	cmp ecx, 0
	je koniec2

	mov dx, tekst_ori[24+esi*2]
	mov w3[esi*2], dx
dalej2:
	inc esi
	dec ecx
	jmp petla2

koniec2:
	nop


mov ecx, liczba_z1
add ecx, liczba_z2
add ecx, liczba_z3

mov esi, 0
mov edi, 0
petla3:
	cmp ecx, 0
	je koniec3

	cmp esi, 5
	jg sprawdz_przedzial

	mov dx, w3[esi*2]
	mov tekst_ori[2*esi], dx

dalej3:
	inc esi
	dec ecx
	jmp petla3

sprawdz_przedzial:
	cmp esi, 12
	jb dalej3
	mov dx, w1[(edi*2)]
	mov tekst_ori[2*esi], dx
	inc edi
	jmp dalej3
	
	
koniec3:
	nop


	push 0
	push offset tytul
	push offset tekst_ori
	push 0

	call _MessageBoxW@16

push 0
call _ExitProcess@4
_main ENDP
end
