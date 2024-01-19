bits 16

section _TEXT class=CODE
global _DELAY
_DELAY:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    
    MOV CX, 0FH
    MOV DX, 4240H
    MOV AH, 86H
    INT 15H 

    pop dx 
    pop cx
    pop bx
    pop ax
    mov sp, bp
    pop bp
    ret