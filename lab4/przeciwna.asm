.686
.model flat

extern _ExitProcess@4 : proc

public _przeciwna
.code
_przeciwna proc

push ebp
mov ebp, esp


push ebx
push ecx


mov ebx, [ebp + 8] ;; adres wskaznika
mov eax, [ebx] ;; wartosc ze wskaznika w eax


neg eax	

mov [ebx], eax



pop ecx
pop ebx
pop ebp
ret

push 0
call _ExitProcess@4
_przeciwna endp
end