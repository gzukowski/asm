.686
.model flat


extern __read : proc
extern __write : proc
EXTERN _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc
public _main


.data 
	tytul db "Tytul", 0H
	znaki db 12 dup (?)


.code

_main proc


mov eax, 532  ;; liczba na 64 bit
mov edx, 0	  ;; liczba na 64 bit


mov ebx, 10   ;; dzielnik 

mov edi, 10 ;; maksymalna ilosc cyfr przy rejestrze 32 bitowym sluzy jako indeksowanie


petla:
	cmp edi, 0
	je koniec


	div ebx ;; dzielimy liczbe rozstawioną na przedziale  edx:eax

	;; reszta zaladowana do edx
	;; iloraz zaladowany do eax
	
	add dl, 30H
	mov znaki[edi], dl
	mov dx, 0
	dec edi


	cmp eax, 0   ;; sprawdzamy czy iloraz jest rowny 0, jesli tak to oznacza ze konwersja sie zakonczyla
	je koniec


	jmp petla


koniec:
	nop


push 12
push offset znaki
push 1

call __write

add esp, 12


push 0
push offset tytul
push dword ptr offset znaki
push 0

call _MessageBoxA@16

push 0
call _ExitProcess@4
_main endp
end
