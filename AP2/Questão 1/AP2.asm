org 0x7e00          ; set initial addres
jmp 0x0000:start			; go to start session

bits 16
titulo db 'AP2 de IHS',0
fim db 'FIM', 0

start:
    xor ax, ax	                        ; ax = 0
    mov ds, ax	                        ; ds = ax = 0
    mov es, ax                          ; es = ax = 0
    
    int 10h

    CLI                                 ; sets interrupt flag to 0
    mov word es:[88H], rotinaDaAP2      ; Coloco no endereço que vamos invocar no indice 22h
    mov es:[8AH], cs                    ; 
    sti                                 ; sets interrupt flag to 1
    
    
    int 22h                             ; chamo a interrupção que faz o que a questão pede
  
    int 16h                             ; chamo uma interrupção de teclado para gerar uma pausa


    call limpaTela                      ; Depois de ser pressionado ENTER, eu limpo a tela
    mov si, fim                         ; movo pra si a string FIM
    call printString                    ; coloco a string na tela pra indicar o fim da atividade

jmp done

rotinaDaAP2:
    push bx                             ; empilho o bx
    push cx                             ; empilho o cx
    push ax                             ; empilho o ax
    push si                             ; empilho o si

    mov si, titulo                      ; coloco em si a string Titulo

    xor cx, cx                          ; zero o cx pra quando a função lengthString ele funcionar como contador
    mov bx, titulo                      ; coloco o endereço da string em bx

       
    call printString                    ; al está recebendo o caractere a ser printado da string "titulo" ; Aqui é printada a string que está em si
    
    mov si, titulo                      ; carrego novamente a string em si
    call lengthString                   ; chamo a função que coloca em cx o tamanho da string titulo
   
    
    pop bx                              ; desempilho o bx
    pop cx                              ; desempilho o cx
    pop ax                              ; desempilho o ax
    pop si                              ; desempilho o si

    iret
  

;; Limpa a tela dos caracteres colocados pela BIOS
limpaTela:
    mov bl, 2
	; Set the cursor to top left-most corner of screen
	mov dx, 0 
    mov bh, 0      
    mov ah, 0x2
    int 0x10

    ; print 2000 blank chars to clean  
    mov cx, 2000 
    mov bh, 0
    mov al, 0x20 ; blank char
    mov ah, 0x9
    int 0x10
    
    ;Reset cursor to ton left-most corner of screen
    mov dx, 0 
    mov bh, 0      
    mov ah, 0xe
    int 0x10
    ret


;; Printa a string que esta em si    
printString: 
	lodsb
	cmp al, 0
	je exit
	mov ah, 0xe
	int 10h	
	jmp printString

exit:
    ret


lengthString:
    lodsb
    cmp al,0
    je .endloop
    mov ah, 0xe
    add cx, 1
    jmp lengthString

    .endloop:
    ret

; Final do código
done:
	times  63*512 - ($-$$) db 0
	;dw 0xAA55 ; boot sector magic number
