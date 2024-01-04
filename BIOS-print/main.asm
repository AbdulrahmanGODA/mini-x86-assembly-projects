org 0x7c00
buffer:
	times 10 db 0
string:
	db "Enter a Name: ", 0

	mov ah, 0x00
	mov al, 0x02
	int 0x10

	mov bx, [string]
	call print

	mov bx, [buffer]

main:
	mov ah, 0x00
	int 0x16
	cmp al, '0'
	je done

	mov ah, 0x0e
	int 0x10
	mov [bx], al
	inc bx
	jmp main
done:
	mov [bx], al
	mov bx, [buffer]
	mov ah, 0x00
	mov al, 0x02
	int 0x10

print:
	mov ah, 0x0e
	mov al, [bx]
	cmp al, '0'
	je exit
	int 0x10
	inc bx
	jmp print
exit:
	ret


jmp $
times 510-($-$$) db 0
db 0x0055, 0x00aa
