.686
.model flat

public _cone_volume

.data
trzy dd 3.0
jeden dd 1.0

;; float cone_volume(unsigned int big_r, unsigned int small_r, float h)
.code

_cone_volume proc
push ebp
mov ebp, esp
push ebx
push edx

mov eax, ebp
add eax, 8 ;; br

mov ebx, ebp
add ebx, 12 ;; sr

mov edx, ebp
add edx, 16  ;; adres h


finit
fld jeden
fld trzy
fdivp st(1), st(0)

;; stan stosu s0 = 1/3

fldpi

fmulp st(1), st(0)

;; stan stosu s0 = pi * 1/3


fld dword ptr [edx]

;; stan stosu s0 = h, s1 = pi * 1/3

fmulp st(1), st(0)

;; stan stosu s0 = h*pi * 1/3


fild dword ptr [eax]
fild dword ptr [eax]

fmulp st(1), st(0)

;; stan stosu s0 = R^2, s1 = h*pi * 1/3

fild dword ptr [ebx]
fild dword ptr [eax]

fmulp st(1), st(0)

;; stan stosu s0= rR s1 = R^2, s2 = h*pi * 1/3


faddp st(1), st(0)


;; stan stosu s0= rR + R^2 , s1 = h*pi * 1/3

fild dword ptr [ebx]
fild dword ptr [ebx]

fmulp st(1), st(0)

faddp st(1), st(0)

;; stan stosu s0= rR + R^2 + r^2 , s1 = h*pi * 1/3


fmulp st(1), st(0)

pop edx
pop ebx
pop ebp
ret
_cone_volume endp
end