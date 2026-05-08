global ft_list_push_front
extern malloc

section .text

; void ft_list_push_front(t_list **begin_list, void *data)
; rdi = begin_list, rsi = data

ft_list_push_front:
    push rbx
    push r12
    push r13

    mov r12, rdi        ; r12 = begin_list
    mov r13, rsi        ; r13 = data

    ; malloc(sizeof(t_list)) = 16 bytes (data ptr + next ptr)
    mov rdi, 16
    call malloc
    test rax, rax
    jz .done            ; si malloc falla, salir sin hacer nada

    ; nuevo->data = data
    mov [rax], r13

    ; nuevo->next = *begin_list
    mov rbx, [r12]
    mov [rax + 8], rbx

    ; *begin_list = nuevo
    mov [r12], rax

.done:
    pop r13
    pop r12
    pop rbx
    ret