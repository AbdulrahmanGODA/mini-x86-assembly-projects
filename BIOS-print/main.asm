org 0x7c00
bits 16 

jmp main
db 0
db "MSWIN4.1" ;OEM Name
dw 512 ;Bytes Per Sector
db 1 ;Sectors Per Cluster
dw 1 ;Reserved Sector Count - 1 For BootSector
db 2 ;Number of File Allocation Tables
dw 0x0e0 ;Max number of Root Entries (16 * 10)
dw 2880 ;Total Sectors
db 0xF0 ;Media Descriptor
dw 9 ;Sectors Per FAT
dw 18 ;Sectors Per Track
dw 2 ;Number of Heads
dd 0 ;Number of Hidden Sectors
dd 0
db 0, 0, 0x29, 0x12, 0x34, 0x56, 0x78, "GODA OS    ", "FAT12   "

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
