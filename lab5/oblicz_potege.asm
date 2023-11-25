.686
.model flat

public _oblicz_potege


.code

_oblicz_potege proc
push ebp
mov ebp, esp
push ebx


; m+2^k
mov eax, ebp
add eax, 8	;; adres m


mov ebx, ebp  
add ebx, 12 ;; adres k


finit
fild dword ptr [eax]
fld1

fscale


fild dword ptr [ebx]

faddp st(1), st(0)






pop ebx
pop ebp
ret
_oblicz_potege endp
end
