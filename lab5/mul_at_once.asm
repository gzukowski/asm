.686
.model flat
.xmm

public _mul_at_once
.data

.code
_mul_at_once PROC
push ebp
mov ebp, esp


pmulld xmm0, xmm1




pop ebp
ret
_mul_at_once endp
end
