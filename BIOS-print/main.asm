org 0x7c00
bits 16 

main:
	call clear
	mov bx, string1
	call print
	call write
	call clear
	mov bx, string2
	call print
	mov bx, buffer
	call print
	call printNL
	call write	
jmp $

clear:
	mov ah, 0x00
	mov al, 0x02
	int 0x10
	ret

write:	mov bx, buffer
wloop:	mov ah, 0x00
	int 0x16
	mov [bx], al
	cmp al, '0'
	je endw
	mov ah, 0x0e
	int 0x10
	inc bx
	jmp wloop
	endw: ret
print:
	mov ah, 0x0e
	mov al, [bx]
	cmp al, '0'
	je endp
	int 0x10
	inc bx
	jmp print
	endp: ret
printNL:
	mov ah, 0x0e
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10
	ret	

string1: db "Enter a Name: ", '0'
string2: db "Welcome ", '0' 
buffer: times 16 db 0

times 510-($-$$) db 0
db 0x55, 0xaa
