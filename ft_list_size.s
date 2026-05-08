global ft_list_size
extern malloc

section .text

; int ft_list_size(t_list *begin_list);
; rdi = begin_list

ft_list_size:
    push rbx
    ;push rbp
    ;push r12
    ;push r13
    xor rbx, rbx

.loop:
    cmp rdi, 0
    je .done
    inc rbx
    mov rdi, [rdi + 8]
    jmp .loop

.done:
    mov rax, rbx
    ;pop r13
    ;pop r12
    ;pop rbp
    pop rbx
    ret