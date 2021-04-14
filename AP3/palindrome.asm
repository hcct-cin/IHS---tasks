section .text
global palindrome

palindrome:
    enter 0,0
    mov eax, [ebp + 8]           ;Getting the string
    mov ecx, [ebp + 12]          ;Getting length

    mov edx, eax                        ;put in DI the begning of the string (index[0])
    add eax, ecx                        ;put in SI the end of the string (index[tamanho-1])
 
check:
        ;cmp byte[edx], 'a'
        ;je .a
        ;jmp done
         mov dl, byte[edx]                   ;put the caracter in al (ou pelo menos tentando kkk)             
         mov al, byte[eax]                   ;put the caracter in cl (ou pelo menos tentando kkk)

        cmp dl, al                      ;compare first and last caracter  
        jne notpalindrome               ; if the first and the last caracter isn't the same got to "notpalindrome"
        add edx, 8                          ; add 1 in di (next caracter)        
        add eax, 8                       ; sub 1 in si (previus caracter)
        loop check                      ; go to check again

        mov eax, 1                      ;is palindrome

        jmp done                        ; end
        .a:
        mov eax, 999
        jmp done

notpalindrome:
        mov eax, 0                      ; isn't palindrome
        jmp done                        ; end
done:
leave
        ret                             ; end
