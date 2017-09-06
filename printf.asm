printf:
        pusha
        str_loop:
                mov al, [si] ;move si to al
                cmp al, 0 ;compare al to 0. 0 means end of string.
                jne print_char ;if not done then print character. if 0 then skip
                popa ;pop everything from stack
                ret ;return to line after printf call

        print_char:
                mov ah, 0x0e ;move forward 1
                int 0x10 ;bios interrupt. print character
                add si, 1 ;add 1 to si
                jmp str_loop
