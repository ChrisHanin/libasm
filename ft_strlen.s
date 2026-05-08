global ft_strlen

section .text

; ft_strlen("hola")


ft_strlen:
	xor rax, rax        ; contador = 0
	cmp rdi, 0
    je .end
	
.loop:
	cmp byte [rdi + rax], 0   ; ¿carácter == '\0'?
	je .end
	inc rax
    jmp .loop

.end:
    ret