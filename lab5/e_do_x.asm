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

fsub st(1), st(0) ; obliczenie czêœci u³amkowej

fxch ; zamiana ST(0) i ST(1)

; po zamianie: ST(0) - czêœæ u³amkowa, ST(1) - czêœæ ca³kowita

f2xm1 ;; (2 do st0) -1 
fld1 ;; zaladowanie 1

faddp st(1), st(0)


; mno¿enie przez 2^(czêœæ ca³kowita)
fscale

; przes³anie wyniku do ST(1) i usuniêcie wartoœci
; z wierzcho³ka stosu
fstp st(1)



push 0
call _ExitProcess@4
_main endp
end