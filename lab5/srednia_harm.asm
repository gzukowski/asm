.686
.model flat

public _srednia_harm 
.data
jeden dd 1.0
wynik dd ?
n dd ?
.code 

_srednia_harm proc
push ebp
mov ebp, esp
push ebx
push edi

mov ebx, [ebp+8];; adres pierwszego elementu tablicy
mov eax, [ebp+12] ;; drugi parametr
mov n, eax

mov edi, 0

finit


fldz
petla:
	cmp eax, 0
	jz zakoncz


	fld dword ptr [ebx + edi]
	fld jeden
	;; stan stosu st(0) = jeden, st(1)= float, st(2) = suma

	fdiv st(0), st(1)

	;; stan stosu st(0) = wynik, st(1)= float, st(2) = suma

	fadd st(0), st(2)
	fstp st(2)

	;; stan stosu st(0) = float,  st(1) = suma
	fstp st(0)


	dec eax
	add edi, 4
	jmp petla


zakoncz:
fild n

fdiv st(0), st(1)


pop edi
pop ebx
pop ebp
ret
_srednia_harm endp
end