org 0x7e00          ; set initial addres
jmp 0x0000:start			; go to start session

bits 16
titulo db 'Pratica 1',0
humberto db 'hcct', 0
gabriel db 'gme', 0
sonikku db 'gfr', 0
malu db 'mlll', 0
bernardo db 'rbnn', 0
msg db 'PRESS ENTER', 0
cadastro db 'Cadastrar conta', 0
busca db 'Buscar conta', 0
nom db 'Nome: ', 0
pf db 'CPF: ', 0
nu db 'Numero: ', 0
igual db 'IGUAL PORRA', 0

search db 0
contadorCPF db 0

index db 0 ; Index do vetor
nome db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
cpf db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
numero db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

start:
    xor ax, ax	; ax = 0
    mov ds, ax	; ds = ax = 0
    mov es, ax  ; es = ax = 0

    mov ax, 0x3     ; set video mode ah=0 al=3
	int 0x10        ; call bios


	;call animacaoColorida

	call menuAndIntegrantes

    .leitura:
        call lerLetra
        cmp al, 13
        je escolha
        jmp .leitura
	    ret

escolha:
    .cad:
        call limpaTela
        
        mov si, titulo
        mov bl,12
        mov ah, 02h
        mov dh, 5
        mov dl, 14
        int 10h
        call printString

        mov si, cadastro  
        mov bl, 10
        mov ah, 02h
        mov dh, 9
        mov dl, 13
        int 10h
        call printString

        mov si, busca  
        mov bl, 15
        mov ah, 02h
        mov dh, 12
        mov dl, 13
        int 10h
        call printString

        call lerLetra

        cmp al, 's'
        je .bus
        cmp al, 13
        je cadastro1

        jmp .cad
    .bus:
        call limpaTela
        
        mov si, titulo
        mov bl,12
        mov ah, 02h
        mov dh, 5
        mov dl, 14
        int 10h
        call printString

        mov si, cadastro  
        mov bl, 15
        mov ah, 02h
        mov dh, 9
        mov dl, 13
        int 10h
        call printString

        mov si, busca  
        mov bl, 10
        mov ah, 02h
        mov dh, 12
        mov dl, 13
        int 10h
        call printString

        call lerLetra

        cmp al, 'w'
        je .cad
        cmp al, 13
        je buscaCPF

        jmp .bus

cadastro1:
    .nome:
        call limpaTela
        mov dh, 9
        mov dl, 10
        mov si, nom
        call moveCursor ; Move o cursor para o centro da tela
        call printString ; Escreve "Nome: " na tela

        xor cl, cl
        mov di, nome
        mov bh, byte[index]
        call pegaAddress
        .loopNome:
            call lerLetra
            
            cmp al, 8  ; 8 = Backspace
            je .backspace
            cmp al, 13 ; 13 = Carriage Return (Enter)
            je .done
            cmp cl, 20 ; 20 é o limite de caracteres
            je .loopNome
            stosb
            inc cl ; Caso o caractere não seja especial e possa ser printado, incrementamos a quantidade de caracteres atual.
            
            call printarLetra
            jmp .loopNome
        .backspace:
            cmp cl, 0
            je .loopNome
            dec di
            dec cl
            mov byte[di], 0
            call delchar
            jmp .loopNome
        .done:
            mov al, 0
            stosb
            ;jmp escolha
    .cpf:
        call limpaTela
        mov dh, 9
        mov dl, 10
        mov si, pf
        call moveCursor ; Move o cursor para o centro da tela
        call printString ; Escreve "Nome: " na tela

        xor cl, cl
        
        mov di, cpf
        mov bh, byte[index]
        call pegaAddress

        .loopCPF:
            call lerLetra
            
            cmp al, 8  ; 8 = Backspace
            je .backspaceCPF
            cmp al, 13 ; 13 = Carriage Return (Enter)
            je .doneCPF
            cmp cl, 11 ; 11 é o tamanho do cpf
            je .loopCPF
            cmp al, '0'
            jl .loopCPF
            cmp al, '9'
            jg .loopCPF
            stosb
            inc cl ; Caso o caractere não seja especial e possa ser printado, incrementamos a quantidade de caracteres atual.
            
            call printarLetra
            jmp .loopCPF
        .backspaceCPF:
            cmp cl, 0
            je .loopCPF
            dec di
            dec cl
            mov byte[di], 0
            call delchar
            jmp .loopCPF
        .doneCPF:
            mov al, 0
            stosb
            
    .numero:
        call limpaTela
        mov dh, 9
        mov dl, 10
        mov si, nu
        call moveCursor ; Move o cursor para o centro da tela
        call printString ; Escreve "Nome: " na tela

        xor cl, cl

        mov di, numero
        mov bh, byte[index]
        call pegaAddress
        .loopNumero:
            call lerLetra
            
            cmp al, 8  ; 8 = Backspace
            je .backspaceNumero
            cmp al, 13 ; 13 = Carriage Return (Enter)
            je .doneNumero
            cmp cl, 4 ; 4 é o tamanho do Numero
            je .loopNumero
            cmp al, '0'
            jl .loopNumero
            cmp al, '9'
            jg .loopNumero
            stosb
            inc cl ; Caso o caractere não seja especial e possa ser printado, incrementamos a quantidade de caracteres atual.
            
            call printarLetra
            jmp .loopNumero
        .backspaceNumero:
            cmp cl, 0
            je .loopNumero
            dec di
            dec cl
            mov byte[di], 0
            call delchar
            jmp .loopNumero
        .doneNumero:
            mov al, 0
            stosb
            jmp done1
    done1:
        add byte[index], 1
        jmp escolha

buscaCPF:
    call limpaTela
    mov si, pf
    mov bl, 15
    mov dh, 10
    mov dl, 12
    call moveCursor
    call printString

    xor cl, cl
    mov di, search
    .loopCPF2:
            call lerLetra
            
            cmp al, 8  ; 8 = Backspace
            je .backspaceCPF2
            cmp al, 13 ; 13 = Carriage Return (Enter)
            je .doneCPF2
            cmp cl, 11 ; 11 é o tamanho do cpf
            je .loopCPF2
            cmp al, '0'
            jl .loopCPF2
            cmp al, '9'
            jg .loopCPF2
            stosb
            inc cl ; Caso o caractere não seja especial e possa ser printado, incrementamos a quantidade de caracteres atual.
            
            call printarLetra
            jmp .loopCPF2
        .backspaceCPF2:
            cmp cl, 0
            je .loopCPF2
            dec di
            dec cl
            mov byte[di], 0
            call delchar
            jmp .loopCPF2
        .doneCPF2:
            mov al, 0
            stosb
            mov di, cpf
            mov si, search
            .compara:
                mov al, byte[di]
                mov ah, byte[si]
                inc di
                inc si
                cmp ah, 0
                je .endString
                cmp al, 0
                je .endString
                cmp ah, al
                je .compara
                jmp .nextCPF
            .endString:
                call limpaTela
                mov si, igual
                mov dh, 12
                mov dl, 12
                call moveCursor
                call printString
                jmp .escape
            .nextCPF:
                mov bh, byte[contadorCPF]
                add byte[contadorCPF], 1
                mov di, cpf
                mov si, search
                call pegaAddress
                jmp .compara

    .escape:
        call lerLetra
        cmp al, 27 ; 27 = Escape
        je escolha
        
        jmp .escape

delchar:
    mov al, 8 ; 8 = Backspace
    call printarLetra
    mov al,''
    call printarLetra
    mov al, 8
    call printarLetra
    ret
  
; mov bh, byte[index]
pegaAddress:
    cmp bh, 0
    je .saiAddress
    add di, 20
    dec bh
    jmp pegaAddress
    .saiAddress:
        ret


;; Limpa a tela dos caracteres colocados pela BIOS
limpaTela:
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
    mov ah, 0x2
    int 0x10
    ret

;; Lê uma letra e armazena em al
lerLetra:
    mov ah, 0
    int 16h
    ret

;; Printa uma letra
printarLetra: 
    mov ah, 0xe
    mov bh, 0
    int 10h
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
animacaoColorida:

	;Colorindo a tela de preto.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 0 
	int 10h	

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h
    mov dx, 500
	;call delay

	;Colorindo a tela de vermelho.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 5
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

    mov dx, 500
    ;call delay
	;Colorindo a tela de preto.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 0  
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h
        inc dx
        inc cx
    mov dx, 500
	;call delay

	;Colorindo a tela de vermelho (fim).
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 1   
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

    mov dx, 500
    ret

;; FunÃ§Ã£o que aplica um delay(improvisado) baseado no valor de dx
delay: 
	mov bp, dx
	back:
	dec bp
	nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
    ret

menuAndIntegrantes:
    
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; mudar cor do curso
    mov bl, 3
    call limpaTela
    
    mov ah, 0
    mov al, 13h
    int 10h

    mov ax, 0
    push ax
    call printaQuadrado

    mov dh, 6  ; Linhas  
    mov dl, 13  ; Colunas
	call moveCursor
	mov si, titulo
	call printString

    mov dh, 10  ; Linhas  
    mov dl, 10  ; Colunas
    call moveCursor
    mov si, malu
    call printString
    
    mov dh, 11  ; Linhas  
    mov dl, 10  ; Colunas
    call moveCursor
    mov si, humberto
    call printString

    mov dh, 12  ; Linhas  
    mov dl, 10  ; Colunas
    call moveCursor
    mov si, bernardo
    call printString

    mov dh, 13  ; Linhas  
    mov dl, 10  ; Colunas
    call moveCursor
    mov si, gabriel
    call printString

    mov dh, 14  ; Linhas  
    mov dl, 10  ; Colunas
    call moveCursor
    mov si, sonikku
    call printString

    mov dh, 19  ; Linhas  
    mov dl, 14  ; Colunas
    call moveCursor
    mov si, msg
    call printString
    pop ax
    ret  

moveCursor:	; printa titulo
    mov bh, 0 
    mov ah, 0x2
    int 0x10
    ret

printaQuadrado:
    ; Selecionando o modo de video
    mov ah, 0
    mov al, 13h
    int 10h

    mov ax, 0
    push ax
    mov dx, 25
    mov cx, 56

    .loop:
        pop ax    
        cmp ax, 200
        je trataAX
        inc ax
        inc cx     
        push ax
        push dx
        push cx
        mov dx, 6
        ;call delay
        pop cx
        pop dx
        call printaPixel
        
        jmp .loop
    
    loop2:
        pop ax    
        cmp ax, 140
        je trataAX2
        inc ax
        inc dx     
        push ax
         push dx
        push cx
        mov dx, 6
        ;call delay
        pop cx
        pop dx
        call printaPixel
        
        jmp loop2

    loop3:
        pop ax    
        cmp ax, 200
        je trataAX3
        inc ax
        dec cx     
        push ax
         push dx
        push cx
        mov dx, 6
        ;call delay
        pop cx
        pop dx
        call printaPixel
        
        jmp loop3

    loop4:
        pop ax    
        cmp ax, 140
        je endLoop
        inc ax
        dec dx     
        push ax
         push dx
        push cx
        mov dx, 6
        ;call delay
        pop cx
        pop dx
        call printaPixel
        
        jmp loop4

    trataAX:
        mov ax, 0
        push ax
        jmp loop2
    
    trataAX2:
        mov ax, 0
        push ax
        jmp loop3

    trataAX3:
        mov ax, 0
        push ax
        jmp loop4

    endLoop:
        ret

    printaPixel:
        mov ah, 0ch
        mov bh, 0
        mov al, 4
        int 10h
        ret

; Final do código
done:
	times  63*512 - ($-$$) db 0
	;dw 0xAA55 ; boot sector magic number

