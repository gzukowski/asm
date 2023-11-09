public suma7

.code
suma7 proc
push rbp
mov rbp, rsp
push rbx


mov rbx, [rbp+48]
add rbx, [rbp+56]
add rbx, [rbp+64]

add rbx, rdx
add rbx, rcx
add rbx, r8
add rbx, r9


mov rax, rbx
pop rbx
pop rbp
ret
suma7 endp
end