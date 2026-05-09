global ft_list_remove_if
extern free

section .text

ft_list_remove_if:
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15
    ;push rax            ; padding — 7 pushes (impar) = stack alineado

    test rdi, rdi
    jz .fin
    test rsi, rsi
    jz .fin
    test rdx, rdx
    jz .fin
    test rcx, rcx
    jz .fin

    mov rbx, rdi        ; begin_list
    mov rbp, rsi        ; data_ref
    mov r12, rdx        ; cmp
    mov r13, rcx        ; free_fct

    mov r14, rbx        ; current_ptr = begin_list
    mov r15, [rbx]      ; current = *begin_list

.loop:
    test r15, r15
    jz .fin

    mov rdi, [r15]
    mov rsi, rbp
    call r12

    test rax, rax
    jnz .next

    mov rbx, r15
    mov rcx, [r15 + 8]
    mov [r14], rcx

    mov rdi, [rbx]
    call r13            ; free_fct(current->data)

    mov rdi, rbx
    call free           ; free(nodo)

    mov r15, [r14]
    jmp .loop

.next:
    lea r14, [r15 + 8]
    mov r15, [r15 + 8]
    jmp .loop

.fin:
    ;pop rax
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    ret