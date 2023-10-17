.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC  ; windows 1250
extern _MessageBoxW@16 : PROC	; utf-16 
extern __read : proc

public _main

.data
	tytul dw 'Z','n','a','k','i',0
	tekst dw 036F6H, 03795H ;tekst dw 'T', 'o',' ', 'j','e', 's', 't',' ' , 'p', 'i', 'e', 's', ' ',



	magazyn16 db 80 dup (?)
	magazyn db 80 dup (?)
	liczba_znakow dd ?
.code
	_main:
		


		push 80 
		push offset magazyn
		push 0
		call __read


		mov ecx, eax ;; licznik petli
		mov ebx, 0 ;;indeks petli

		mov edi, 0


		petla:
			cmp ecx, 1
			je koniec

			mov dl, magazyn[ebx]
			cmp dl, '/'
			je sprawdz

			;;movzx dx, dl
			mov magazyn16[edi], dl

		dalej:
			inc ebx ;; indeks zczytanego
			inc edi ;; indeks utf16
			dec ecx
			jmp petla

		sprawdz:
			
			cmp magazyn[ebx+1], 'a'
			je wstaw_a
			cmp magazyn[ebx+1], 'A'
			je wstaw_a_duze
			cmp magazyn[ebx+1], 'c'
			je wstaw_c
			cmp magazyn[ebx+1], 'C'
			je wstaw_c_duze
			cmp magazyn[ebx+1], 'e'
			je wstaw_e
			cmp magazyn[ebx+1], 'E'
			je wstaw_e_duze
			cmp magazyn[ebx+1], 'l'
			je wstaw_l
			cmp magazyn[ebx+1], 'L'
			je wstaw_l_duze
			cmp magazyn[ebx+1], 'n'
			je wstaw_n
			cmp magazyn[ebx+1], 'N'
			je wstaw_n_duze
			cmp magazyn[ebx+1], 'o'
			je wstaw_o
			cmp magazyn[ebx+1], 'O'
			je wstaw_o_duze
			cmp magazyn[ebx+1], 's'
			je wstaw_s
			cmp magazyn[ebx+1], 'S'
			je wstaw_s_duze
			cmp magazyn[ebx+1], 'z'
			je wstaw_z
			cmp magazyn[ebx+1], 'Z'
			je wstaw_z_duze
			
			
			mov dl, magazyn[ebx]
			;;movzx dx, dl
			mov magazyn16[edi], dl
			jmp dalej


		wstaw_a:
			mov al, 0B9H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_a_duze:
			mov al, 0A5H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_c:
			mov al, 0E6H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_c_duze:
			mov al, 0C6H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_e:
			mov al, 0EAH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_e_duze:
			mov al, 0CAH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_l:
			mov al, 0B3H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_l_duze:
			mov al, 0A3H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_n:
			mov al, 0F1H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_n_duze:
			mov al, 0D1H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_o:
			mov al, 0F3H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_o_duze:
			mov al, 0D3H
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_s:
			mov al, 09CH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_s_duze:
			mov al, 08CH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_z:
			mov al, 0BFH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej
		wstaw_z_duze:
			mov al, 0AFH
			mov magazyn16[edi], al
			add ebx, 1
			jmp dalej



		koniec:
			nop

		

		push 0
		push offset tytul
		push offset magazyn16
		push 0 

		call _MessageBoxA@16
		push 0 ; kod powrotu programu

		call _ExitProcess@4
	END
