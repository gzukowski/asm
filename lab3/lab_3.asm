.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
.data
	

public _main

dwanascie dd 12
dekoder db "0123456789AB"
obszar db 10 dup (?)

.code
potega proc ;;podnosi 12 do potegi zawartej w ecx
push eax
push ebx
push edx
push edi
push esi
push ebp


cmp ecx, 0
je zero


mov eax, 12

petla_potega:
	cmp ecx, 1
	je koniec_potega

	mul dwanascie
	dec ecx
	jmp petla_potega


zero:
	mov ecx, 1
	jmp koniec_potega
koniec_potega:
	mov ecx,eax
pop ebp
pop esi
pop edi
pop edx
pop ebx
pop eax
ret

potega endp

wyswietl_eax proc
pusha

mov edi, 9
petla:
	mov ebx, 0
	mov edx,0
	div dwanascie

	mov bl, dekoder[edx]
	
	mov obszar[edi], bl
	dec edi


	cmp eax, 0
	je koniec_petla
	
	jmp petla

	
koniec_petla:
nop

mov ebx, 0 ;; licznik
mov esi, 0 ;; indeksowanie
sub esp, 12
mov edx, esp
inc edi
wyswietlanie:
	cmp edi, 10
	je koniec_wyswietlania


	cmp bl, cl
	je zeruj_licznik


	mov al, obszar[edi]
	mov byte ptr[edx][esi], al

	inc bl
	inc edi
	inc esi
	jmp wyswietlanie
	


zeruj_licznik:
	mov byte ptr [edx][esi], ' '
	mov ebx, 0
	inc esi
	jmp wyswietlanie



koniec_wyswietlania:

push esi
push edx
push 1
call __write

add esp,12


add esp, 12

popa
ret
wyswietl_eax endp
_main proc
mov eax, 0ffffffffh

mov cl, 1


call wyswietl_eax
nop
push 0 
call _ExitProcess@4

_main endp
end

