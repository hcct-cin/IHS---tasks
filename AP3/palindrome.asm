section .text
global palindrome

palindrome:
    enter 0,0
    mov si, [ebp + 8]           ;Getting the string
    mov cx, [ebp + 12]          ;Getting length
    leave

    mov di, si                        ;put in DI the begning of the string (index[0])
    add si, cx                        ;put in SI the end of the string (index[tamanho-1])
 
check:
        mov ax, di                    ;put the caracter in al (ou pelo menos tentando kkk)             
        mov cx, si                    ;put the caracter in cl (ou pelo menos tentando kkk)

        cmp bl, cl                      ;compare first and last caracter  
        jne notpalindrome               ; if the first and the last caracter isn't the same got to "notpalindrome"
        inc di                          ; add 1 in di (next caracter)        
        dec si                          ; sub 1 in si (previus caracter)
        loop check                      ; go to check again

        mov eax, 1                      ;is palindrome

        jmp done                        ; end

notpalindrome:
        mov eax, 0                      ; isn't palindrome
        jmp done                        ; end
done:
        ret                             ; end
