.686
.model flat



extern _ExitProcess@4 : proc
extern __write : proc
public _main

.data
pietnascie dd 15.0
jeden_pol dd 1.5
buffor db 30 dup (0)
liczba dd ?

.code
_wyswietl_eax proc
pushad

fld jeden_pol
fst st(1)
fist dword ptr liczba

fsub st(1), st(0)

;; st0 = calkowita, st



popad
ret
_wyswietl_eax endp


_main proc


finit

fldz
fptan

call _wyswietl_eax


clc

mov eax, 0ffffffffh
mov edx, 1 
mov ebx, 1

div ebx

push 0
call _ExitProcess@4
_main endp
end