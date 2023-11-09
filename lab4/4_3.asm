.686
.model flat


extern _ExitProcess@4 : proc
public _odejmij_jeden

.code

_odejmij_jeden proc
push ebp

mov ebp, esp
push ebx

mov ebx, [ebp + 8] ;;

mov eax, [ebx] ;; w ecx wartosc  z pod wskaznika pierwszego

mov ecx, [eax] ;; w edx wartosc z pod wskaznika drugiego


dec ecx

mov [eax], ecx


pop ebx
pop ebp
ret
_odejmij_jeden endp
end
