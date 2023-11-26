.686
.model flat
.xmm


public _pm_jeden

.data
jedynki dd 1.0, 1.0, 1.0, 1.0

.code

_pm_jeden proc
push ebp
mov ebp, esp
mov eax, [ebp+8]


movups xmm5,  jedynki
movups xmm6, [eax]

ADDSUBPS xmm6, xmm5


movups [eax], xmm6

pop ebp
ret
_pm_jeden endp
end