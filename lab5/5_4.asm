.686
.model flat
.xmm
public _int2float

.code
_int2float proc
push ebp
mov ebp, esp 
push ebx

mov ebx, [ebp + 8]  ;; w ebx znajduje sie adres pierwszego elementu tablicy

mov eax, [ebp + 12]  ;; w eax adres obszaru na floaty


cvtpi2ps xmm5, qword PTR [ebx]

movups [eax], xmm5





pop ebx
pop ebp
ret
_int2float endp
end