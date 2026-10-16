jmp main

; ======================
;        Textos
; ======================
	combustivelTexto: string "FUEL:"
	gameOverTexto: string "GAMEOVER"
; ======================
;     Variaveis Nave
; ======================
	; Posicoes do corpo com relacao a cabeca da nave
	CorpoNave: var #5
		static CorpoNave + #0, #0	; Cabeca		[0] = 0
		static CorpoNave + #1, #39	; Asa esquerda	[1] = 39
		static CorpoNave + #2, #40	; Corpo			[2] = 40
		static CorpoNave + #3, #41	; Asa direita 	[3] = 41
		static CorpoNave + #4, #80	; Bunda 		[4] = 80
	CorpoNaveCaracteres: string "rtzmu"

	posNaveX: var #1
	posNaveY: var #1

	combustivelNave: var #1 		; 0-30
; ======================
; Variaveis Helicopteros
; ======================
	; Posicoes do corpo com relacao ao parte superior esquerda do helicoptero
	CorpoHelicotero: var #4
		static CorpoHelicotero + #0, #0		; Sup Esquerda	[0] = 0
		static CorpoHelicotero + #1, #1		; Sup Direita	[1] = 39
		static CorpoHelicotero + #2, #41	; Inf Direita	[2] = 40
		static CorpoHelicotero + #3, #40	; Inf Esquerda 	[3] = 41
	CorpoHelicopteroCaracters: string "nold" 
	
	; Guarda a posição de  5 helicopteros
	; 2000 -> Objeto Morto
	posHelicopterosX: var #5 
	posHelicopterosY: var #5

contadorFrames: var #1						; Conta frames para operar

main:
	call ApagaTela
    loadn r0, #20 ; Nasce no centro da tela
    loadn r1, #25 ; Y sempre fica em 27
	loadn r2, #30 ; comeca com o maximo de combustivel
    store posNaveX, r0
    store posNaveY, r1
	store combustivelNave, r2

	loadn r0, #20
	loadn r1, #6
	store posHelicopterosX, r0
	store posHelicopterosY, r1

	mainLoop:
		call DesenhaTodosHelicopteros
		call DesenharNave
		call DesenhaCombustivel
		call ConsomeCombustivel
		call Delay
		call ApagaTela
		call MovimentaNave
		call MovimentaTodosHelicopteros
		call IncrementaContadorFrames
		jmp mainLoop

    halt

IncrementaContadorFrames:
	push r0

	load r0, contadorFrames
	inc r0
	store contadorFrames, r0

	pop r0
    rts

GameOver:
	loadn r0, #616
	loadn r1, #gameOverTexto
	loadn r2, #0
	call ImprimeStr
	
	loadn r0, #'r'
	GameOver_Loop:
		inchar r1
		cmp r0, r1
		jeq main
		jne GameOver_Loop

	rts

; ======================
; 	   Funções Nave
; ======================
DesenharNave:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    load r0, posNaveX
    load r1, posNaveY

    ; calcula posicao absoluta
    loadn r6, #40
    mul r1, r1, r6
    add r0, r0, r1 ; r0 = posX + 40 * posY

    ; carrega o vetor corpo nave
    loadn r1, #CorpoNave
    loadn r2, #CorpoNaveCaracteres
    
    loadn r6, #5

    ; print cabeca
    DesenharNaveLoop:
        mov r3, r0 ; colocar posicao absoluta em r3
        loadi r4, r1 ; r4 = corponave[]-> diferenca relativa

        add r3, r3, r4 ; r3 = posicao relativa + corponave[] 
        loadi r5, r2 ; r5 = caracter para imprimir
        outchar r5, r3 ; imprime

        inc r1
        inc r2
        
        dec r6
        jnz DesenharNaveLoop

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

ApagaNave:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    load r0, posNaveX
    load r1, posNaveY

    ; calcula posicao absoluta
    loadn r6, #40
    mul r1, r1, r6
    add r0, r0, r1 ; r0 = posX + 40 * posY

    ; carrega o vetor corpo nave
    loadn r1, #CorpoNave
    loadn r5, #' '        ; <<< carrega o espaco ANTES do loop

    loadn r6, #5

    ApagaNaveLoop:
        mov r3, r0 ; posicao absoluta em r3
        loadi r4, r1 ; r4 = offset relativo
        add r3, r3, r4 ; <<< faltava somar o offset

        outchar r5, r3 ; <<< registrador, nao literal

        inc r1
        dec r6
        jnz ApagaNaveLoop

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

MovimentaNave:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	inchar r0 ; if(r0 == 'a') esquerda() else if(r0 == 'd') direita()
	loadn r1, #'a'
	cmp r0, r1
	jeq MovimentaEsquerda
	loadn r1, #'d'
	cmp r0, r1
	jeq MovimentaDireita
	jmp MovimentaFim

	MovimentaEsquerda:
		load r0, posNaveX
		loadn r1, #1; Limite a esquerda

		dec r0 ; Movimenta para esquerda
		cmp r0, r1 ; if(posX < 1) return
		jle MovimentaFim
		store posNaveX, r0
		jmp MovimentaFim

	MovimentaDireita:
		load r0, posNaveX
		loadn r1, #38; Limite a direita

		inc r0 ; Movimenta para direita
		cmp r0, r1 ; if(posX > 39) return
		jgr MovimentaFim
		store posNaveX, r0
		jmp MovimentaFim

	MovimentaFim:
		pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ConsomeCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, contadorFrames
	loadn r1, #100
	mod r0, r0, r1

	jnz ConsomeCombustivel_Fim

	; decrementa combustivel
	load r0, combustivelNave
	dec r0
	store combustivelNave, r0

	jz GameOver

	ConsomeCombustivel_Fim:
		pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

DesenhaCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #1160 ; Pos primeiro caracter
	loadn r1, #combustivelTexto
	loadn r2, #0
	call ImprimeStr

	loadn r0, #1166 ; Pos primeiro bloco de combustivel
	load r1, combustivelNave
	loadn r2, #125 ; bloco preenchido
	loadn r3, #' '
	loadn r4, #1200 ; limite tela

	DesenhaCombustivel_Loop:
		outchar r2, r0
		inc r0
		dec r1
		jnz DesenhaCombustivel_Loop
	
	DesenhaCombustivel_Loop2: ; apaga onde não tem mais combustivel
		outchar r3, r0
		inc r0
		cmp r0, r4
		jne DesenhaCombustivel_Loop2

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ======================
;  Funções Helicopteros
; ======================

DesenhaTodosHelicopteros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r1, #5
	loadn r0, #0

	DesenhaTodosHelicopteros_Loop:
		call DesenhaHelicoptero
		inc r0
		dec r1
		jnz DesenhaTodosHelicopteros_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; r0 = indice do helicoptero
DesenhaHelicoptero:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    loadn r1, #posHelicopterosX
    loadn r2, #posHelicopterosY

	; Aponta para o helicoptero certo
	add r1, r0, r1
	add r2, r0, r2

	loadi r0, r1
	loadi r1, r2

    ; calcula posicao absoluta
    loadn r6, #40
    mul r1, r1, r6
    add r0, r0, r1 ; r0 = posX + 40 * posY

    ; carrega o vetor corpo nave
    loadn r1, #CorpoHelicotero
    loadn r2, #CorpoHelicopteroCaracters
    
    loadn r6, #4

    ; print cabeca
    DesenharHelicopteroLoop:
        mov r3, r0 ; colocar posicao absoluta em r3
        loadi r4, r1 ; r4 = corpohelicoptero[]-> diferenca relativa

        add r3, r3, r4 ; r3 = posicao relativa + corpohelicoptero[] 
        loadi r5, r2 ; r5 = caracter para imprimir
        outchar r5, r3 ; imprime

        inc r1
        inc r2
        
        dec r6
        jnz DesenharHelicopteroLoop

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

MovimentaTodosHelicopteros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r1, #5
	loadn r0, #0

	MovimentaTodosHelicopteros_Loop:
		call MovimentaHelicoptero
		inc r0
		dec r1
		jnz MovimentaTodosHelicopteros_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; r0 = indice do helicoptero
MovimentaHelicoptero:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r1, #posHelicopterosY
	add r1, r0, r1
	
	loadi r0, r1

	load r2, contadorFrames
	loadn r3, #100
	mod r2, r2, r3

	jnz MovimentaHelicoptero_Fim

	inc r0
	storei r1, r0

	MovimentaHelicoptero_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

Delay:
    push r0
    push r1

    loadn r0, #10
Delay_Loop1:
    loadn r1, #1000
Delay_Loop2:
    dec r1
    jnz Delay_Loop2
    dec r0
    jnz Delay_Loop1

    pop r1
    pop r0
    rts

; imprime string do primeiro caracter até o \0
; r0 = posicao primeiro caracter
; r1 = endereco que comeca a mensagem
; r2 = cor da mensagem
; não guarda na tela 0! Isso era um problema antes
ImprimeStr:
	push r0	
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
   ImprimeStr_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r6	; Resgata os valores dos registadores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	