.686
.model flat

extern _ExitProcess@4 : proc

public _plus_jeden
.code
_plus_jeden proc
push ebp

mov ebp, esp

push ebx


mov eax, [ebp+8] ;; adres zmiennej w eax

mov ebx, [eax] ;; wskaznik pod adresem

inc ebx

mov [eax], ebx	




pop ebx
pop ebp
ret
push 0
call _ExitProcess@4
_plus_jeden endp
end