bits 16
section _TEXT class=CODE

global _CLEAR

_CLEAR:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx

	mov ah, 0x00
	mov al, 0x02
	int 0x10
    
    pop dx 
    pop cx
    pop bx
    pop ax
    mov sp, bp
    pop bp
    ret