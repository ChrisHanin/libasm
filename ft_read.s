global ft_read
extern __errno_location

section .text

; ssize_t read(int fd, void *buf, size_t count)

ft_read:
    mov rax, 0          ; syscall: read
    syscall

    cmp rax, 0
    jl .error           ; si rax < 0 → error

    ret

.error:
    neg rax             ; rax = -rax → errno positivo

    mov rdi, rax        ; pasar errno como argumento
    call __errno_location

    mov [rax], edi      ; *errno = error

    mov rax, -1         ; return -1
    ret



; mov rax, 1
; mov rdi, 1
; mov rsi, msg
; mov rdx, 5
; syscall
; 
; 👉 cuando NO vienes de C