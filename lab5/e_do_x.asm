.686
.model flat

extern _ExitProcess@4 : proc



public _main


.data
	dwa dd  2.0


.code

_main proc

finit
fldl2e ;; laduje na wierzcholek log2(e)
fld dwa

fmulp st(1), st(0)

fst st(1) ;; przekopiowanie wyniku do st1

frndint

fsub st(1), st(0) ; obliczenie cz�ci u�amkowej

fxch ; zamiana ST(0) i ST(1)

; po zamianie: ST(0) - cz�� u�amkowa, ST(1) - cz�� ca�kowita

f2xm1 ;; (2 do st0) -1 
fld1 ;; zaladowanie 1

faddp st(1), st(0)


; mno�enie przez 2^(cz�� ca�kowita)
fscale

; przes�anie wyniku do ST(1) i usuni�cie warto�ci
; z wierzcho�ka stosu
fstp st(1)



push 0
call _ExitProcess@4
_main endp
end