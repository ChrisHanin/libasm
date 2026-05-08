global ft_strcpy

section .text

; char	*ft_strcpy(char *dest, const char *src)

ft_strcpy:
    mov rax, rdi        ; guardar dest para retorno
	cmp rdi, 0
	je .null
	cmp rsi, 0
	je .null

.loop:
    mov dl, [rsi]       ; leer byte de src
    mov [rdi], dl       ; escribir en dest
    cmp dl, 0
    je .end
    inc rsi
    inc rdi
    jmp .loop

.null:
    xor rax, rax        ; return NULL
    ret

.end:
    ret
