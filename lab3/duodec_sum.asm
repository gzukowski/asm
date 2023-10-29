.686
.model flat


extern __read : proc
extern __write : proc
extern _ExitProcess@4 : proc

public _main


.data
	dwanascie dd 12
	dziesiec dd 10

.code

wczytaj_duodec_eax proc
push ebx
push ecx
push edx
push edi
push esi
push ebp

sub esp, 6
mov edi, esp


push 4
push edi
push 0
call __read


mov eax, 0
mov esi, 0
konwersja:
	
	cmp esi, 2
	je koniec_konwersji


	mul dwanascie
	mov edx, 0

	mov dl, [edi][esi]

	cmp dl, 60H
	ja mala_litera

	cmp dl, 40H
	ja duza_litera



	sub dl, 30H
	dodanie:
	add eax, edx

	inc esi
	jmp konwersja

mala_litera:
	sub dl, 'a'-10
	jmp dodanie
duza_litera:
	sub dl, 'A'-10
	jmp dodanie
koniec_konwersji:
	nop

add esp, 12
add esp, 6

pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret
wczytaj_duodec_eax endp


wyswietl_dec_eax proc
pusha

sub esp, 12
mov edi, esp


mov esi, 10
wyswietlanie:
	cmp esi, 0 
	jz zakoncz_wypeln

	mov edx, 0
	div dziesiec

	add dl, 30H
	mov [edi][esi], dl

	cmp eax, 0
	jz wypelnianie

	dec esi
	jmp wyswietlanie


wypelnianie:
	cmp esi, 0
	jz zakoncz_wypeln
	dec esi
	mov byte ptr [edi][esi], ' '
	jmp wypelnianie
	

zakoncz_wypeln:
mov byte ptr [edi][0], 10
mov byte ptr [edi][11], 0

push 12
push edi
push 1
call __write
add esp,12

add esp, 12
popa
ret
wyswietl_dec_eax endp
_main proc


call wczytaj_duodec_eax

mov ecx, eax

call wczytaj_duodec_eax

add eax, ecx

call wyswietl_dec_eax
push 0
call _ExitProcess@4
_main endp
end
