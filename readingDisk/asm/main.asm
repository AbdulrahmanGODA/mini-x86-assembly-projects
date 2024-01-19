bits 16

section _ENTRY class=CODE
extern _CSTART_
global entry
entry:
	;CLEAR
	mov ah, 0x00
	mov al, 0x02
	int 0x10
	
	cli
	mov ax, ds
	mov ss, ax
	mov sp, 0
	mov bp, sp
	sti
	call _CSTART_

	cli
	hlt
	