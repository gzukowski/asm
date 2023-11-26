.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat
public _dodaj_SSE
.code


_dodaj_SSE proc
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, [ebp+8] ; adres pierwszej tablicy
mov edi, [ebp+12] ; adres drugiej tablicy
mov ebx, [ebp+16] ; adres tablicy wynikowej

;; tablice zawieraja po 16 liczb 8 bitowych

movups xmm5, [esi] 
movups xmm6, [edi]

paddsb xmm5, xmm6

movups [ebx], xmm5

pop edi
pop esi
pop ebx
pop ebp
ret
_dodaj_SSE endp
end