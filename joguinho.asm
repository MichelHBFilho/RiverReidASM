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

	; Três combustiveis ao maximo na tela ao mesmo tempo
	CombustivelObjetoCaracter: var #1
		static CombustivelObjetoCaracter + #0, #'F'
	posCombustiveisX: var #3
	posCombustiveisY: var #3
		
	; 3 tiros ao mesmo tempo na tela parece razoavel
	posTirosX: var #3
	posTirosY: var #3
	CorpoTiroCaracter: string "a"
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
    loadn r0, #20 				; Nasce no centro da tela
    loadn r1, #25 				; Y sempre fica em 27
	loadn r2, #30 				; comeca com o maximo de combustivel
    store posNaveX, r0
    store posNaveY, r1
	store combustivelNave, r2	

	loadn r0, #20
	loadn r1, #6
	store posHelicopterosX, r0
	store posHelicopterosY, r1

	loadn r0, #17
	loadn r1, #10
	store posCombustiveisX, r0
	store posCombustiveisY, r1

	mainLoop:
		call Desenha
		call ConsomeCombustivel
		call Delay
		call Apaga
		call MovimentaNave
		call MovimentaTodosHelicopteros
		call MovimentaTodosObjetoCombustivel
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

	; RESETA o Stack Pointer
	; A função que chamou o GameOver não fez pop dos registradores
	; Invés de fazer pop de cada registrador, prefiro resetar
	; Uma vez que os valores ali não me interessam mais!
	; Portanto, note que se der um rts aqui vai dar pau!
	; Mas não pretendemos retornar, pretendemos dar um jmp main

	loadn r0, #32767 			; Nao da para fazer loadn sp, #32767
	mov sp, r0					; Pois não tem caminho

	loadn r0, #616
	loadn r1, #gameOverTexto
	loadn r2, #0
	call ImprimeStr
	
	loadn r0, #'r'
	GameOver_Loop: 				; while(inchar != 'r')
		inchar r1
		cmp r0, r1
		jeq main
		jne GameOver_Loop

	; Não passa por aqui!

Desenha:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call DesenharNave
	call DesenhaTodosHelicopteros
	call DesenhaTodosObjetoCombustivel

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

Apaga:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call ApagaNave
	call ApagaTodosHelicopteros

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
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

    DesenharNaveLoop:		; for(int i = 0; i < 5; i++)
        mov r3, r0 			; colocar posicao absoluta em r3
        loadi r4, r1 		; r4 = corponave[]-> diferenca relativa

        add r3, r3, r4 		; r3 = posicao relativa + corponave[] 
        loadi r5, r2 		; r5 = caracter para imprimir
        outchar r5, r3 		; imprime

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
	
	; TODO - preencher com o fundo 
    loadn r5, #' '			; Preenche com espaço branco!

    loadn r6, #5

    ApagaNaveLoop:
        mov r3, r0 			; posicao absoluta em r3
        loadi r4, r1 		; r4 = offset relativo
        add r3, r3, r4

        outchar r5, r3

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

	inchar r0 				; if(r0 == 'a') esquerda() else if(r0 == 'd') direita()
	loadn r1, #'a'
	cmp r0, r1
	jeq MovimentaEsquerda
	loadn r1, #'d'
	cmp r0, r1
	jeq MovimentaDireita
	jmp MovimentaFim

	MovimentaEsquerda:
		load r0, posNaveX
		loadn r1, #1		; Limite a esquerda

		dec r0 				; Movimenta para esquerda
		cmp r0, r1 			; if(posX < 1) return
		jle MovimentaFim
		store posNaveX, r0
		jmp MovimentaFim

	MovimentaDireita:
		load r0, posNaveX
		loadn r1, #38		; Limite a direita

		inc r0 				; Movimenta para direita
		cmp r0, r1 			; if(posX > 39) return
		jgr MovimentaFim
		store posNaveX, r0
		jmp MovimentaFim

	MovimentaFim:
		pop r6
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
	call DesenhaCombustivel ; So desenha o combustivel quando muda!

	ConsomeCombustivel_Fim:
		pop r6
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

	loadn r0, #1160 			; Pos primeiro caracter
	loadn r1, #combustivelTexto
	loadn r2, #0
	call ImprimeStr

	loadn r0, #1166 			; Pos primeiro bloco de combustivel
	load r1, combustivelNave
	loadn r2, #125 			; bloco preenchido
	loadn r3, #' '
	loadn r4, #1200 			; limite tela

	DesenhaCombustivel_Loop:
		outchar r2, r0			; imprime bloco preenchido onde tem combustivel
		inc r0
		dec r1					; if(r1 != 0) goto Loop
		jnz DesenhaCombustivel_Loop
	
	; depois do LOOP1 o r0 aponta para a primeira posicao que não tem combustivel

	DesenhaCombustivel_Loop2: 	; apaga onde não tem mais combustivel
		outchar r3, r0			; imprime espaco em r0
		inc r0
		cmp r0, r4				; if(r0 != limitetela) goto loop
		jne DesenhaCombustivel_Loop2

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

DesenhaTodosObjetoCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posCombustiveisX
	loadn r1, #posCombustiveisY
	loadn r2, #3
	load r6, CombustivelObjetoCaracter

	DesenhaObjetoCombustivel_Loop:
		loadi r3, r0
		loadi r4, r1
		loadn r5, #2000
		cmp r4, r5
		jeq DesenhaObjetoCombustivel_Loop_Fim

		loadn r5, #40

		mul r4, r4, r5
		add r3, r3, r4
		outchar r6, r3

		DesenhaObjetoCombustivel_Loop_Fim:
			inc r0
			inc r1
			dec r2
			jnz DesenhaObjetoCombustivel_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

MovimentaTodosObjetoCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posCombustiveisX
	loadn r1, #posCombustiveisY
	loadn r2, #3
	loadn r6, #' '

	load r3, contadorFrames
	loadn r4, #100
	mod r3, r3, r4
	jnz MovimentaTodosObjetoCombustivel_Fim

	MovimentaTodosObjetoCombustivel_Loop:
		loadi r3, r0
		loadi r4, r1

		; checa se morreu
		loadn r5, #2000
		cmp r4, r5
		jeq MovimentaTodosHelicopteros_Loop_Fim

		loadn r5, #40

		mul r4, r4, r5
		add r3, r3, r4
		outchar r6, r3					; Apaga o combustivel

		; Atualizo o y do combustivel e storo
		loadi r4, r1
		inc r4

		loadn r5, #28 					; Se passou disso sem tocar aviao some
		cmp r4, r5
		jne MovimentaTodosHelicopteros_Loop_Salva
		loadn r4, #2000

		MovimentaTodosHelicopteros_Loop_Salva:
			storei r1, r4
		MovimentaTodosHelicopteros_Loop_Fim:
			inc r0
			inc r1
			dec r2
			jnz DesenhaObjetoCombustivel_Loop

	MovimentaTodosObjetoCombustivel_Fim:
		pop r6
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

	DesenhaTodosHelicopteros_Loop:			; for(int i = 0; i < 5; i++)
		call DesenhaHelicoptero
		inc r0								; r0 é o argumento da função indica o indice do Helicoptero
		dec r1								; inves de comparar eu vou decrementando o r1
		jnz DesenhaTodosHelicopteros_Loop	; quando zerar r1 acabou

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

	; checa se o heliptero ja morreu
	loadn r2, #2000
	cmp r1, r2
	jeq DesenharHelicoptero_Fim

    ; calcula posicao absoluta
    loadn r6, #40
    mul r1, r1, r6
    add r0, r0, r1 ; r0 = posX + 40 * posY

    ; carrega o vetor corpo nave
    loadn r1, #CorpoHelicotero
    loadn r2, #CorpoHelicopteroCaracters
    
	; eu nao gosto de guardar tao hardocodado o tamanho dos vetores
    loadn r6, #4

    DesenharHelicopteroLoop:; for(int i = 0; i < 4; i++)
        mov r3, r0 			; colocar posicao absoluta em r3
        loadi r4, r1 		; r4 = corpohelicoptero[]-> diferenca relativa

        add r3, r3, r4 		; r3 = posicao relativa + corpohelicoptero[] 
        loadi r5, r2 		; r5 = caracter para imprimir
        outchar r5, r3

        inc r1				; vou para o proximo elemento dos vetores
        inc r2				; corpo e caracteres
        
        dec r6
        jnz DesenharHelicopteroLoop

	DesenharHelicoptero_Fim:
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

	loadn r1, #5					; quantidade de helicopteros
	loadn r0, #0

	MovimentaTodosHelicopteros_Loop:; for(int i = 0; i < 5; i++)
		call MovimentaHelicoptero	; r0 é o parametro de indice

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

	loadn r1, #posHelicopterosY		; So preciso do y para movimentar o helicoptero!
	add r1, r0, r1
	
	loadi r2, r1

	load r3, contadorFrames
	loadn r4, #100					; Movimenta o helicoptero a cada 100 frames
	mod r3, r3, r4

	jnz MovimentaHelicoptero_Fim

	; if(helicoptero_morto) return;
	loadn r4, #2000 ; 2000 -> Helicoptero morto
	cmp r2, r4
	jeq MovimentaHelicoptero_Fim

	inc r2							; move o helicoptero para baixo
	loadn r4, #27
	cmp r2, r4
	jle MovimentaHelicoptero_Salvar ; if(!helicoptero_visivel) matar();

	MovimentarHelicoptero_Matar:
		loadn r2, #2000

	MovimentaHelicoptero_Salvar:
		storei r1, r2

	loadn r4, #1
	call ChecaColisaoHelicoptero
	cmp r7, r4
	jeq GameOver

	MovimentaHelicoptero_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; r0 = indice do helicoptero
; r7 = retorno
ChecaColisaoHelicoptero:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	; Y do helicoptero
	loadn r1, #posHelicopterosY
	add r1, r1, r0
	loadi r2, r1

	; if(helicoptero_morto) return;
	loadn r3, #2000
	cmp r2, r3
	jeq ChecaColisaoHelicoptero_Morto

	; X do helicoptero
	loadn r1, #posHelicopterosX
	add r1, r1, r0
	loadi r1, r1

	; r5 = pos abs helicoptero
	loadn r3, #40
	mul r2, r2, r3
	add r5, r1, r2

	; r2 = pos abs nave
	load r2, posNaveX
	load r3, posNaveY
	loadn r4, #40
	mul r3, r3, r4
	add r2, r2, r3

	loadn r0, #CorpoNave
	loadn r1, #5
	loadn r3, #CorpoHelicotero
	loadn r4, #4
	call ChecaColisao
	jmp ChecaColisaoHelicoptero_Fim

	ChecaColisaoHelicoptero_Morto:
		loadn r7, #0

	ChecaColisaoHelicoptero_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ApagaTodosHelicopteros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r1, #5
	loadn r0, #0

	ApagaTodosHelicopteros_Loop:
		call ApagaHelicoptero
		inc r0
		dec r1
		jnz ApagaTodosHelicopteros_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

ApagaHelicoptero:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    loadn r1, #posHelicopterosX
    loadn r2, #posHelicopterosY

	add r1, r1, r0
	add r2, r2, r0

	loadi r0, r1
	loadi r1, r2

	; checa se morreu
	loadn r2, #2000
	cmp r1, r2
	jeq ApagaHelicoptero_Fim

    ; calcula posicao absoluta
    loadn r6, #40
    mul r1, r1, r6
    add r0, r0, r1 ; r0 = posX + 40 * posY

    ; carrega o vetor corpo nave
    loadn r1, #CorpoHelicotero
    loadn r5, #' '

    loadn r6, #4

    ApagaHelicopteroLoop:
        mov r3, r0 ; posicao absoluta em r3
        loadi r4, r1 ; r4 = offset relativo
        add r3, r3, r4

        outchar r5, r3

        inc r1
        dec r6
        jnz ApagaHelicopteroLoop

	ApagaHelicoptero_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; r0: endereco corpo 1
; r1: tamanho corpo 1
; r2: pos absoluta corpo 1
; r3: endereco corpo 2
; r4: tamanho corpo 2
; r5: pos absoluta corpo 2
; r7: retorno
ChecaColisao:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	ChecaColisao_Loop1:
		loadi r6, r0
		add r6, r6, r2

		push r3
		push r4

		ChecaColisao_Loop2:
			loadi r7, r3
			add r7, r7, r5
			cmp r6, r7
			jeq ChecaColisao_Colidiu
			inc r3
			dec r4
			jnz ChecaColisao_Loop2

		pop r4
		pop r3

		inc r0
		dec r1
		jnz ChecaColisao_Loop1

	loadn r7, #0				; terminou os dois loops sem bater
	jmp ChecaColisao_Fim

	ChecaColisao_Colidiu:
		pop r4					; desempilha o que o Loop1 deixou
		pop r3
		loadn r7, #1

	ChecaColisao_Fim:
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