.686
.model flat

public _find_max
.data
dwa dd 2.0
g dd 9.81

.code

_find_max proc
push ebp
mov ebp, esp
push ebx

mov eax, ebp
add eax, 8 ;;adres v

mov ebx, ebp
add ebx, 12 ;;adres alfy


finit

fld g

fld dword ptr [ebx]

fsincos

; stan stosu st(0) = cos, st1=sin, st2=g

fmulp st(1), st(0)

; stan stosu st(0) = cossin, st1=g

fmul dwa

; stan stosu st(0) = 2cossin, st1=g

fld dword ptr [eax]
fld dword ptr [eax]

fmulp st(1), st(0)

; stan stosu st0=v^2, st(1) = 2cossin, st2=g

fmulp st(1), st(0)

; stan stosu st0=v^2*2cossin, st(1) =g

fdiv st(0), st(1)





pop ebx
pop ebp
ret
_find_max endp
end