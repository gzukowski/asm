.686
.model flat
.xmm

public _wyznacz_max

.data

zapis dd 4 dup (0)

.code
_wyznacz_max proc
push ebp
mov ebp, esp


mov eax, [ebp + 8] ;; w eax adres tablicy

mov ecx, [ebp+12] ;; wartosc progu


push ecx
movups xmm0, [esp]
shufps xmm0, xmm0, 0
pop ecx



push ecx
finit
fild dword ptr [esp]
pop ecx

fst zapis


push zapis
movups xmm0, [esp]
shufps xmm0, xmm0, 0
pop zapis


movups xmm1, [eax]

maxps xmm0, xmm1

movups [eax], xmm0



pop ebp
ret
_wyznacz_max endp
end