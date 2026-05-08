global suma

section .text

; suma(a, b)

suma:
    MOV RAX, RDI   ; a
    ADD RAX, RSI   ; b
    ADD RAX, RDX   ; c
    RET
	


; MOV RDI, 5   ; primer argumento
; MOV RSI, 3   ; segundo argumento
; CALL suma    ; llamar función
; resultado queda en RAX