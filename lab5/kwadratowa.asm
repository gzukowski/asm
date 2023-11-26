.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main
.data
	
wsp_a dd 2.0
wsp_b dd -1.0
wsp_c dd -15.0
dwa dd 2.0
cztery dd 4.0
x1 dd ?
x2 dd ?

.code
_main PROC

	finit
	fld wsp_a
	fld wsp_b
	fst st(2)

	fmul st(0), st(0)

	fld cztery

	fmul st(0), st(2) ; obliczenie 4 * a
	fmul wsp_c ;; domnozenie do 4ac
	fsubp st(1), st(0) ; obliczenie b^2 - 4 * a * c
	; sytuacja na stosie: ST(0) = b^2 - 4 * a * c, ST(1) = a,; ST(2) = b

	fldz ;; zaladowanie 0 na stos koprocesora
	; sytuacja na stosie
	; sytuacja na stosie: ST(0)= 0, ST(1) = b^2 - 4 * a * c, ST(2) = a,; ST(3) = b
	fcomi st, st(1)

	fstp st ;; usuniecie zera z wierzcholka koprocesora


	; sytuacja na stosie: ST(0) = b^2 - 4 * a * c, ST(1) = a,  ST(2) = b
	ja delta_ujemna

	;; delta dodatnia

	fxch st(1) ;; zamienia st 0 z st1 miejscami na stosie


	; sytuacja na stosie:ST(0) = a,  ST(1) = b^2 - 4 * a * c,  ST(2) = b

	fadd st(0), st(0) ; ; obliczenie 2 * a
	fstp st(3)

	; sytuacja na stosie:,  ST(0) = b^2 - 4 * a * c,  ST(1) = b,  ST(2) =2a

	fsqrt ;; pierwiastek z delty
	fst st(3)

	; sytuacja na stosie:  , ST(0) = sqrt (b^2 - 4 * a * c),  ST(1) = b,  ST(2) =2a, ST(3) = sqrt (b^2 - 4 * a * c);

	fchs ;; zmiana znaku st (0)

	fsub st(0), st(1) ;; -delta - b
	fdiv st(0), st(2) ;; dzielenie wyniku przez 2a
	fstp x1

	; sytuacja na stosie:  ,  ST(0) = b,  ST(1) =2a, ST(2) = sqrt (b^2 - 4 * a * c);

	fchs ;; zmiana znaku b
	fadd st(0), st(2) ;; -delta - b
	fdiv st(0), st(1) ;; dzielenie wyniku przez 2a
	fstp x2

	fstp st(0)
	fstp st(0)


	delta_ujemna:




	push 0
	call _ExitProcess@4
_main ENDP
END