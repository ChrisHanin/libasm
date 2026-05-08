global ft_write
extern __errno_location

section .text

ft_write:
    cmp rsi, 0          ; Verificar si buffer es NULL
    je .error

    mov rax, 1          ; syscall: write
    syscall

    cmp rax, 0
    jl .error           ; si rax < 0 → error
    ret

.error:
    neg rax             ; rax = -rax → errno positivo

    mov r8, rax        ; pasar errno como argumento
    call __errno_location

    mov [rax], r8      ; *errno = error

    mov rax, -1         ; return -1
    ret



; mov rax, 1
; mov rdi, 1
; mov rsi, msg
; mov rdx, 5
; syscall
; 
; 👉 cuando NO vienes de C