global ft_list_sort
extern ft_list_size

section .text

; void ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *));

ft_list_sort:
    push rbx
    push r12
    push r13
    push r14
    push r15

    cmp rdi, 0
    je .fin
    cmp rsi, 0
    je .fin

    mov r14, rdi            ; guardar begin_list
    mov r15, rsi            ; guardar cmp

    mov rdi, [r14]
    call ft_list_size
    mov r13, rax            ; size
    dec r13                 ; size - 1 pasadas
    cmp r13, 0
    jle .fin

    mov r12, 0              ; pasada actual

.pass:
    cmp r12, r13
    je .fin

    mov rbx, r14            ; ptr al puntero que vamos a modificar
    mov rdi, [r14]          ; primer nodo
    mov rcx, 0              ; prev = NULL

.swap_loop:
    test rdi, rdi
    jz .next_pass
    
    mov rsi, [rdi + 8]      ; next = nodo->next
    test rsi, rsi
    jz .next_pass

    ; llamar a cmp
    push rdi
    push rsi
    mov rdi, [rdi]
    mov rsi, [rsi]
    call r15
    pop rsi
    pop rdi

    cmp rax, 0
    jle .no_swap

    ; INTERCAMBIO
    mov rdx, [rsi + 8]      ; guardar next->next
    
    ; ajustar el puntero anterior
    cmp rcx, 0
    jne .has_prev
    
    ; es el primer nodo
    mov [rbx], rsi          ; *begin_list = next
    jmp .do_swap

.has_prev:
    mov [rcx + 8], rsi      ; prev->next = next

.do_swap:
    mov [rsi + 8], rdi      ; next->next = current
    mov [rdi + 8], rdx      ; current->next = next->next
    
    ; después del swap, el nodo actual pasa a ser next
    mov rcx, rsi            ; prev = next
    mov rdi, [rsi + 8]      ; current = next->next
    jmp .swap_loop

.no_swap:
    mov rcx, rdi            ; prev = current
    mov rdi, [rdi + 8]      ; current = current->next
    jmp .swap_loop

.next_pass:
    inc r12
    jmp .pass

.fin:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret