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
;Extended Boot Record
db 0, 0, 0x29, 0x12, 0x34, 0x56, 0x78, "GODA OS    ", "FAT12   "

;LBA to CHS convertion
;Cylinder = (LBA / sectorPerTrack) / heads
;Head = (LBA / sectorPerTrack) % heads
;Sector = (LBA % sectorPerTrack) + 1

main:
    mov dl, 0 ;driver number
    mov ax, 1 ; sector address in LBA 
    mov cl, 1 ;sector number int0x013
    mov bx, 0x7e00 ;pointer to a buffer

    call diskRead

    hlt

diskRead:
    push ax
    push bx
    push cx
    push dx
    push di

    call LBAtoCHS

    mov ah, 0x02
    mov di, 3 ;counter

retry: 
    stc 
    int 0x013
    jnc doneRead
    call diskReset
    dec di
    test di,di
    jnz retry

failDiskRead:
    mov si, readFailure
    call print
    hlt

doneRead:
    mov si, bx
    call print

    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

diskReset:
    pusha
    mov ah, 0
    stc
    int 0x013
    jc failDiskRead
    popa 
    ret

LBAtoCHS:
;input: LBA in ax
;return: 
;   cx bits 0-5 => sector number
;   cx bits 6-15 => cylinder
;   dh => heads

    push ax
    push bx
    push dx

    xor dx, dx ;dx = 0
    xor bx, bx
    mov bx, 18 ;Sectors Per Track
    div word bx ;(dx,ax)/(s16) => Q in ax, R in dx

    inc dx
    mov cx, dx

    xor dx, dx ;dx = 0
    xor bx, bx
    mov bx, 2 ;Number of Heads
    div word bx ;(dx,ax)/(s16) => Q in ax, R in dx
    ;Cylinder in ax
    ;Head in dx
    mov dh, dl
    mov ch, al
    shl ah, 6
    or cl, ah

    pop ax
    mov dl, al
    pop bx
    pop ax
    ret

print:
    push ax
	mov ah, 0x0e
	mov al, [si]
	cmp al, '0'
	je endp
	int 0x10
	inc si
	jmp print
	endp: 
    pop ax
    ret

jmp $

readFailure: db "Failed to read from disk", 0
readSuccess: db "Successfully read", 0
times 510-($-$$) db 0
db 0x55, 0xaa

;sector two

times 512 db 'A'

;sector three

times 512 db 'B'