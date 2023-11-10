.686
.model flat

public _wyswietl_date
extern _GetSystemTime@4 : PROC

.code

_wyswietl_date proc
push ebp
mov ebp, esp


push ebx
call _GetSystemTime@4

mov ax,  [ebx + 10]

pop ebp
ret
_wyswietl_date endp
end