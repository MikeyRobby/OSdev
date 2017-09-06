; starts in 16 bit real mode by default
[org 0x7c00]
[bits 16]

section .text

	global main

main:

cli
jmp 0x000:ZeroSeg
ZeroSeg:
	xor ax, ax	
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov sp, main
	cld
sti

push ax
xor ax, ax
int 0x13
pop ax


; store STR in si
;mov si, STR
;call printf

mov si, STR_LOAD
call printf

;mov si, STR_T
;call printf

;mov si, STR_TH
;call printf

mov al, 1
mov cl, 2
mov dx, [0x7c00 + 510]
call readDisk

call printh


jmp $

%include "./printf.asm"
%include "./readDisk.asm"
%include "./printh.asm"

;STR: db 'Hello World', 0x0e, 0x0d, 0
DISK_ERR_MSG: db 'Error Loading Disk.', 10, 13, 0
STR_LOAD: db 'Loading...', 10, 13, 0x0, 0x0d, 0
;STR_T: db 'Testing...', 10, 13, 0x0, 0x0d, 0
;STR_TH: db 'Test Success.',10, 13, 0x0, 0x0d, 0
;TEST_STR: db 'Loading...', 10, 13, 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

;test:
;	mov si, TEST_STR
;	call printf

times 512 db 0
