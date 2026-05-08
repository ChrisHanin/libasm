global ft_strcmp

section .text

; int	ft_strcmp("hola", "holo")


ft_strcmp:
.loop:
	mov al, [rdi]        ; cargar byte de s1
    mov dl, [rsi]        ; cargar byte de s2

	cmp al, dl
    jne .diff            ; si son distintos → salir

	cmp al, 0
	je .end

	inc rdi
	inc rsi
	jmp .loop

.diff:
	movzx rax, al       ; extender a 64 bits
	movzx rdx, dl
	sub rax, rdx         ; resultado = s1[i] - s2[i]
	ret

.end:
    xor rax, rax         ; return 0
    ret