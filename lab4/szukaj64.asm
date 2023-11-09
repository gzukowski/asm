public szukaj64_max
.code
szukaj64_max PROC
push rbx
push rsi
push rdi

sub rdx, 1 ;;
mov rsi, 0 ;; indeksowanie
mov rbx, [rcx] ;; pierwszy element jako max
petla:
	cmp rdx, 0
	je zakoncz

	cmp rbx, [rcx + rsi*8]
	jl zmien_max

	inc rsi
	dec rdx
	jmp petla

zmien_max:
	mov rbx, [rcx + rsi*8]
	inc rsi
	dec rdx
	jmp petla



zakoncz:
	

mov rax, rbx
pop rbx
pop rsi
pop rdi
ret
szukaj64_max ENDP
END