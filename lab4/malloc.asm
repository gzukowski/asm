.686
.model flat
extern _malloc : proc

;int funkcja(int e){
;	int h, *i;
;	i = (int*)malloc(e*sizeof(int));
;	if (i == null) return -1;
;	for(h= 0; h < e; h++){
;		(*i) = 3 * h-1;
;		i++
;
;}
;	return e;
;}

public _funkcja


.data
	trzy dd 3
	cztery dd 4
.code
_funkcja proc
push ebp
mov ebp, esp

push ebx
push edi
push esi
mov ebx, [ebp + 8] ;; wartosc e znjduje sie w ebx

mov esi, ebx ;; zachowanie wartosci e w rejestrze ecx


mov eax, ebx
mul cztery
mov ebx, eax


push ebx
call _malloc
pop ebx;; wyczyszczenie stosu z malloca

; adres zajetej pamieci znajduje sie w eax


cmp eax, 0
je zakoncz_null


mov ebx, eax ;;  adres zajetej pamieci znajduje sie w ebx

mov edi, 0 ;; indeksowanie
petla:
	cmp esi, 0
	je zakoncz

	mov eax, edi
	mul trzy
	dec eax

	mov [ebx+edi*4], eax

	inc edi
	dec esi
	jmp petla


zakoncz_null:
	mov eax, 0FFFFFFFFH
zakoncz:

mov eax, ebx

pop esi
pop edi
pop ebx
pop ebp
ret
_funkcja endp
end