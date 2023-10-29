.686
.model flat

extern __write : proc
extern _ExitProcess@4 : proc
public _main


.data
	dziesiec dd 10

.code
wyswietl_eax proc
pusha

sub esp, 12
mov edi, esp

mov esi, 10
petla2:
	mov edx, 0

	div dziesiec
	
	add dl, 30H
	mov [edi][esi], dl

	cmp eax, 0
	jz start_wypeln

	dec esi
	jmp petla2

start_wypeln:
	cmp esi, 0
	jz koniec_wypeln
	dec esi
	mov byte ptr [edi][esi], ' '
	jmp start_wypeln

koniec_wypeln:
	mov byte ptr [edi][0], 10
	mov byte ptr [edi][11], 0



push 12
push edi
push 1
call __write


add esp, 24
nop	
popa
ret
wyswietl_eax endp
wyswietl_ujemne_eax proc
pusha

sub esp, 13   ;; 12 bajtow na stos
mov edi, esp   ;; zapisanie adresu zarezerwowanego obszaru

neg eax

mov esi, 11
petla:
	mov edx, 0

	div dziesiec
	
	add dl, 30H
	mov [edi][esi], dl
	
	cmp eax, 0
	jz zakoncz_petle

	dec esi
	jmp petla
zakoncz_petle:
	cmp esi, 1
	jz zakoncz_wypeln
	dec esi
	mov  byte ptr [edi][esi], ' '
	jmp zakoncz_petle


zakoncz_wypeln:
	mov  byte ptr[edi][0], 10
	mov  byte ptr[edi][1], '-'
	mov byte ptr[edi][12], 0


push 13
push edi
push 1
call __write


add esp, 25
popa
ret
wyswietl_ujemne_eax endp

_main proc

mov esi, 0

mov eax, 1 ;; aktualny
mov ebx, 1 ;; poprzednik
call wyswietl_eax
inc esi
ciag:
	cmp esi, 30
	je koniec_ciagu

	test esi, 00000001H
	jz dodawanie

	jmp odejmowanie

	wyswietlanie:
	test eax, 80000000H
	jnz ujemne

	call wyswietl_eax

	inc esi
	jmp ciag


ujemne:
	call wyswietl_ujemne_eax
	inc esi
	jmp ciag
dodawanie:
	add ebx, esi
	mov eax, ebx
	jmp wyswietlanie

odejmowanie:
	sub ebx, esi
	mov eax, ebx
	jmp wyswietlanie




koniec_ciagu:
	nop
push 0
call _ExitProcess@4
_main endp
end
