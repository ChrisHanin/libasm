global ft_atoi_base
extern ft_strlen
extern ft_write

section .data
    str_w_base      db "Error: wrong base", 10, 0
    str_w_base_len  equ $ - str_w_base - 1

section .text

ft_atoi_base:
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi
    mov r13, rsi

    test r12, r12
    jz .fa_return_zero
    test r13, r13
    jz .fa_return_zero

    mov rdi, r13
    call vb_validar_base
    test rax, rax
    jz .fa_return_zero

    mov rdi, r13
    call ft_strlen
    mov r15, rax

    mov rdi, r12
    call sw_skip_whitespace
    mov r12, rax

    mov r14, 1
    movzx rax, byte [r12]
    cmp al, '+'
    je .fa_positive
    cmp al, '-'
    jne .fa_convert
    neg r14
    inc r12
    jmp .fa_convert

.fa_positive:
    inc r12

.fa_convert:
    xor rbx, rbx

.fa_loop:
    movzx rcx, byte [r12]
    test rcx, rcx
    jz .fa_finish

    mov rdi, r13
    mov sil, cl
    call ib_index_in_base
    cmp rax, -1
    je .fa_finish

    imul rbx, r15
    add rbx, rax

    inc r12
    jmp .fa_loop

.fa_finish:
    mov rax, rbx
    imul rax, r14
    jmp .fa_return

.fa_return_zero:
    xor rax, rax

.fa_return:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret


vb_validar_base:
    push rbx
    push r12
    push r13

    mov rbx, rdi
    call ft_strlen
    cmp rax, 2
    jl .vb_invalid

    xor r12, r12

.vb_check_chars:
    movzx rcx, byte [rbx + r12]
    test rcx, rcx
    jz .vb_check_dups

    cmp rcx, '+'
    je .vb_invalid
    cmp rcx, '-'
    je .vb_invalid
    cmp rcx, ' '
    je .vb_invalid
    cmp rcx, 9
    je .vb_invalid
    cmp rcx, 10
    je .vb_invalid
    cmp rcx, 13
    je .vb_invalid

    inc r12
    jmp .vb_check_chars

.vb_check_dups:
    xor r12, r12

.vb_outer:
    movzx rcx, byte [rbx + r12]
    test rcx, rcx
    jz .vb_valid

    mov r13, r12
    inc r13

.vb_inner:
    movzx rdx, byte [rbx + r13]
    test rdx, rdx
    jz .vb_next_outer

    cmp rcx, rdx
    je .vb_invalid

    inc r13
    jmp .vb_inner

.vb_next_outer:
    inc r12
    jmp .vb_outer

.vb_valid:
    mov rax, 1
    jmp .vb_done

.vb_invalid:
    mov rdi, 2
    mov rsi, str_w_base
    mov rdx, str_w_base_len
    call ft_write
    xor rax, rax

.vb_done:
    pop r13
    pop r12
    pop rbx
    ret


ib_index_in_base:
    xor rax, rax

.ib_loop:
    movzx rcx, byte [rdi + rax]
    test rcx, rcx
    jz .ib_not_found

    cmp cl, sil
    je .ib_found

    inc rax
    jmp .ib_loop

.ib_not_found:
    mov rax, -1

.ib_found:
    ret


sw_skip_whitespace:
    mov rax, rdi

.sw_loop:
    movzx rcx, byte [rax]
    test rcx, rcx
    jz .sw_done

    cmp rcx, ' '
    je .sw_next
    cmp rcx, 9
    je .sw_next
    cmp rcx, 10
    je .sw_next
    cmp rcx, 13
    je .sw_next
    jmp .sw_done

.sw_next:
    inc rax
    jmp .sw_loop

.sw_done:
    ret