.686
.model flat

extern _ExitProcess@4 : proc
extern __read : proc
extern __write : proc 
public _main

.data
	dekoder db "0123456789AB"
	mnoznik dd 12
	dziesiec dd 10
	wynik db 10 dup(?)	
.code 

uzupelnij_dziesietnie proc
pusha
mov eax, edx ;; reszta z dzielenia trafia do eax
mov edx, 0
mov ebx, 3
mov edi, 7

petla_2:

	cmp ebx, 0
	je end_petla_2

	mul dziesiec
	mov edx, 0
	div ecx

	add al, 30H
	mov wynik[edi], al

	inc edi
	dec ebx
	mov eax, edx
	jmp petla_2



end_petla_2:
popa
ret
uzupelnij_dziesietnie endp



wypisz_eax proc
pusha

mov ebx, 0
mov edi, 5
petla:
	mov edx, 0
	div dziesiec


	add dl, 30H
	mov wynik[edi], dl
	cmp eax, 0
	jz petla2

	dec edi
	cmp edi, 0
	jz zakoncz_petle
	jmp petla



petla2:
	cmp edi, 0
	jz zakoncz_petle
	dec edi
	mov wynik[edi], ' '
	jmp petla2


zakoncz_petle:
	mov wynik[edi], ' '
popa
ret
wypisz_eax endp



wczytaj_do_eax_duodec proc
push ebx
push ecx
push edx
push edi
push esi
push ebp


sub esp, 6 ;; rezerwowanie 3 bajtow na stosie
mov edi, esp ;; zapisanie adresu zarezerwowanego obszaru


;; zczytanie liczby
push 4
push edi
push 0
call __read

add esp, 12
;;mov byte ptr [edi][2], 10

;; konwersja na binarny
mov eax, 0 ;; wyzerowanie sumowania
mov esi, 0 ;; wyzerowanie indeksowania
mov ebx, 0
konwersja:
	;mov bl, [edi][esi]
	

	cmp esi, 2
	je byl_enter
	;cmp bl, 10 ;; sprawdz enter
	mov bl, [edi][esi]
	

	mov edx, 0
	mul mnoznik


	cmp bl, 60H
	ja litera_mala

	cmp bl, 40H
	ja litera_duza
	nop

	sub bl, 30H
	nop
	add eax, ebx
	inc esi
	jmp konwersja

litera_duza:
	sub bl, 'A' - 10
	add eax, ebx
	inc esi
	jmp konwersja

litera_mala:
	sub bl, 'a' - 10
	add eax, ebx
	inc esi
	jmp konwersja
	
	
byl_enter:
	mov ecx, eax

add esp, 6 ;; 1READ i 3 bajty na poczatku


pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret
wczytaj_do_eax_duodec endp
_main proc


call wczytaj_do_eax_duodec

mov ecx, eax


call wczytaj_do_eax_duodec

mov ebx, eax ;; przepisanie wyniku pierwszego zczytania
mov eax, ecx
mov ecx, ebx



mov edx, 0

div ecx

;;calosc w eax  ;; reszta w edx

call wypisz_eax

mov wynik[6], '.'

call uzupelnij_dziesietnie


push 10
push offset wynik
push 1
call __write

add esp, 12

push 0
call _ExitProcess@4
_main endp
end
