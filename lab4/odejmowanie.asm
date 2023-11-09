.686
.model flat

public _odejmowanie

.code
_odejmowanie proc
push ebp
mov ebp, esp
push ebx
push edx

mov ebx, [ebp + 12] ;; adres odjemnika
mov edx, [ebx] ;; w edx jest odjemnik

mov ebx, [ebp + 8] ;; adres wskaznika na 
mov eax, [ebx] ;; w eax wskaznik na wartosc

mov ebx, [eax] ;; w ebx jest odjemna


sub ebx, edx
mov eax, ebx

pop edx
pop ebx
pop ebp
ret
_odejmowanie endp
end