.686
.model flat


public _nowy_exp


.data
jeden dd 1.0
potega dd ?
silnia dd ?

.code
_nowy_exp proc
push ebp
mov ebp, esp
push ebx

mov ebx, ebp 
add ebx, 8 ;; ebx zawiera adres floata

mov eax, 1 ;; licznik
mov potega, eax ;; licznik aktualnej potegi
mov silnia, 0

finit
fld jeden ;; zaladowanie silni
fld jeden ;; zaladowanie sumy


petla:
	cmp potega, 19
	je zakoncz
	;; stan stosu s(0) = suma, s(1)= potega

	fild potega ;; zaladowana potega na stos 
	fld dword ptr [ebx] ;; zaladowany x na stos
	
	;; stan stosu s(0) = x, s(1) = potega, , s(2) = suma, s3 = silnia

	fyl2x ;; y = st1, x=st0

	;; stan stosu s(0) = alog2(x), s(1) = suma, s2 = silnia
	fldz
	;; stan stosu s(0)= 0, s1= alog2(x), s(2) = suma, s3 = silnia
	fxch
	fst st(1)

	;; stan stosu s(0) = alog2(x), s(1) = alog2(x), s(2) = suma , s3 = silnia


	frndint
	;; zaokraglenie

	fsub st(1), st(0)

	;; stan stosu s(0) = alog2(x) calkowite, s(1) = alog2(x) ulamkowa, s(2) = suma, s3 = silnia

	fxch
	;; stan stosu  s(0) = alog2(x) ulamkowa, s(1) = alog2(x) calkowite, s(2) = suma, s3 = silnia

	f2xm1

	fld jeden

	faddp st(1), st(0)

	;; stan stosu  s(0) = alog2(x) ulamkowa ready, s(1) = alog2(x) calkowite, s(2) = suma, s3 = silnia

	fscale

	;; stan stosu  s(0) = spotegowana liczba, s(1) = alog2(x) calkowite, s(2) = suma, s3 = silnia

	fstp st(1)
	
	add silnia, 1

	fild silnia

	;; stan stosu s0 = silnia_numer,  s(1) = spotegowana liczba, s(2) = suma, s3 = silnia

	fmulp st(3), st(0)

	;;  s(0) = spotegowana liczba, s(1) = suma, s2 = silnia

	fdiv st(0), st(2)


	faddp st(1), st(0)

	add potega, 1
	jmp petla

zakoncz:
pop ebx
pop ebp
ret
_nowy_exp endp
end