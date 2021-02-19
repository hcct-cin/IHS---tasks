org 0x7c00          ; set initial addres
jmp start			; go to start session
bits 16
titulo db 'Pratica 1',0
humberto db 'HUMBERTO COSTA', 0
gabriel db 'GABRIEL EVANGELISTA', 0
malu db 'MARIA LUISA', 0
bernardo db 'RAFAEL BERNARDO', 0



start:
    xor ax, ax	; ax = 0
    mov ds, ax	; ds = ax = 0
    mov es, ax  ; es = ax = 0

	mov ax, 0x3     ; set video mode ah=0 al=3
	int 0x10        ; call bios


	call animacaoColorida

	call menuAndIntegrantes

	ret

limpaTela:
;; Limpa a tela dos caracteres colocados pela BIOS
	; Set the cursor to top left-most corner of screen
	mov dx, 0 
    mov bh, 0      
    mov ah, 0x2
    int 0x10

    ; print 2000 blanck chars to clean  
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
	call delay

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
    call delay
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
	call delay

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


delay: 
;; FunÃ§Ã£o que aplica um delay(improvisado) baseado no valor de dx
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
    mov bl, 4
    call limpaTela
    
    mov ah, 0
    mov al, 13h
    int 10h

    mov ax, 0
    push ax
    call printaQuadrado

	call moveCursor0
	mov si, titulo
	call printString

    call moveCursor1
    mov si, malu
    call printString
    
    call moveCursor2
    mov si, humberto
    call printString

    call moveCursor3
    mov si, bernardo
    call printString

    call moveCursor4
    mov si, gabriel
    call printString

 

ret  

moveCursor0:	; printa titulo
    mov bh, 0 
    mov dh, 6  ; Linhas  
    mov dl, 13  ; Colunas
    mov ah, 0x2
    int 0x10
ret

moveCursor1:    ; printa primeiro integrante
    mov bh, 0 
    mov dh, 14  ; Linhas  
    mov dl, 10  ; Colunas
    mov ah, 0x2
    int 0x10
ret

moveCursor2:    ; printa segundo integrante
    mov bh, 0 	
    mov dh, 15  ; Linhas  
    mov dl, 10  ; Colunas
    mov ah, 0x2
    int 0x10
ret

moveCursor3:    ; printa terceiro integrante
    mov bh, 0 
    mov dh, 16  ; Linhas  
    mov dl, 10  ; Colunas
    mov ah, 0x2
    int 0x10
ret

moveCursor4:	; printa quarto integrante
    mov bh, 0 
    mov dh, 17  ; Linhas  
    mov dl, 10  ; Colunas
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
        call delay
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
        call delay
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
        call delay
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
        call delay
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
	times  510 - ($-$$) db 0
	dw 0xAA55 ; boot sector magic number

