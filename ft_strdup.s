global ft_strdup
extern __errno_location
extern malloc
extern ft_strcpy
extern ft_strlen
extern ft_write

; section .data
; msg db "A", 0

section .text

; char *strdup(const char *s)

ft_strdup:
    push rbx

    cmp rdi, 0
    je .null

    mov rbx, rdi    ;no usar r8, los call pueden sobre escribirlos

    call ft_strlen
    mov rdi, rax
    inc rdi

    call malloc
    cmp rax, 0
    je .null
    
    mov rsi, rbx
    mov rdi, rax
    call ft_strcpy
    pop rbx
    ret

.null:
    pop rbx
    xor rax, rax
    ret

; ft_strdup2:
;     cmp rdi, 0
;     ;jmp .write
;     ;jmp .write2
;     je .null
;     ;jmp .write
;     mov r8, rdi
; 
; 
;     call ft_strlen
;     mov rdi, rax
;     call malloc
;     cmp rax, 0
;     je .null
;     ;jmp .write
;     mov rsi, r8
;     mov rdi, rax
;     call ft_strcpy
;     ret
; 
; .write:
;     mov r8, rax
;     mov r9, rdi
;     mov r10, rsi
;     mov rax, 1
;     mov rdi, 1
;     mov rsi, msg
;     mov rdx, 1
;     syscall
;     mov rax, r8
;     mov rdi, r9
;     mov rsi, r10
;     ret
; 
; .write2:
;     mov r8, rdi
;     mov rax, 1
;     mov rdi, 1
;     mov rsi, r8
;     mov rdx, 5
;     syscall
;     mov rdi, r8
; 
; .null:
;     xor rax, rax
;     ret
; 
; 