global ft_write
extern __errno_location

section .text

ft_write:
    push r8

    mov rax, 1
    syscall

    test rax, rax
    jns .ok

    neg rax
    mov r8, rax
    call __errno_location
    mov [rax], r8d
    mov rax, -1

    pop r8
    ret

.ok:
    pop r8
    ret
