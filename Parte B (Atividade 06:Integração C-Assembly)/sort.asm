section .text
global sort

sort:

.gettingVar:
    enter 0,0
    mov edi, [ebp + 8]           ;Getting the array
    mov ecx, [ebp + 12]          ;Getting length
 
.outloop:
    pusha                         ; saving the array and the length
    mov     esi, edi
.loop1:
    lodsd
    cmp     eax, [esi]            ; check if the values are less or equal
    jle     short .endloop
    xchg    eax, [esi]            
.endloop:
    stosd                        
    loop    .loop1
    popa                          ; taking back array and the length
    loop    .outloop            
    
    leave

    mov eax, [edi]

    ret