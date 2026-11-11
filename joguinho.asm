jmp main

; ======================
;        Textos
; ======================
	combustivelTexto: string "FUEL:"
	gameOverTexto: string "GAMEOVER"
	reiniciarTexto: string "APERTE R PARA REINICIAR"
	scoreTexto: string "SCORE: "
; ======================
;     Variaveis Nave
; ======================
	; Posicoes do corpo com relacao a cabeca da nave
	TamanhoCorpoNave: var #1
	    static TamanhoCorpoNave + #0, #5
	CorpoNave: var #5
		static CorpoNave + #0, #0	; Cabeca		[0] = 0
		static CorpoNave + #1, #39	; Asa esquerda	[1] = 39
		static CorpoNave + #2, #40	; Corpo			[2] = 40
		static CorpoNave + #3, #41	; Asa direita 	[3] = 41
		static CorpoNave + #4, #80	; Bunda 		[4] = 80
	CorpoNaveCaracteres: var #5
		static CorpoNaveCaracteres + #0, #'r'	; r cabeça
		static CorpoNaveCaracteres + #1, #'t'	; t asa esquerda
		static CorpoNaveCaracteres + #2, #'z'	; z meio
		static CorpoNaveCaracteres + #3, #'m'	; m asa direita
		static CorpoNaveCaracteres + #4, #'u'	; u bunda
    posNave: var #1
	combustivelNave: var #1 		; 0-30
; ======================
; Variaveis Combustível
; ======================
	; Três combustiveis ao maximo na tela ao mesmo tempo
	CombustivelObjetoCaracter: var #1
		static CombustivelObjetoCaracter + #0, #2918    ; f amarelo
	CorpoCombustivelObjeto: var #1
		static CorpoCombustivelObjeto + #0, #0
    QuantidadeCombustiveis: var #1
        static QuantidadeCombustiveis + #0, #3
	posCombustiveis: var #3
; ======================
;    Variaveis Tiros
; ======================
	; 3 tiros ao mesmo tempo na tela parece razoavel
	QuantidadeTiros: var #1
	    static QuantidadeTiros + #0, #3
	posTiros: var #3
	CorpoTiroCaracter: var #1
		static CorpoTiroCaracter + #0, #2409            ; i vermelho claro
; ======================
; Variaveis Helicopteros
; ======================
	; Posicoes do corpo com relacao ao parte superior esquerda do helicoptero
	TamanhoCorpoHelicoptero: var #1
	    static TamanhoCorpoHelicoptero + #0, #4
	CorpoHelicoptero: var #4
		static CorpoHelicoptero + #0, #0	; Sup Esquerda	[0] = 0
		static CorpoHelicoptero + #1, #1	; Sup Direita	[1] = 39
		static CorpoHelicoptero + #2, #41	; Inf Direita	[2] = 40
		static CorpoHelicoptero + #3, #40	; Inf Esquerda 	[3] = 41
	CorpoHelicopteroCaracters: var #4
		static CorpoHelicopteroCaracters + #0, #'n'	; n Sup Esquerda
		static CorpoHelicopteroCaracters + #1, #'o'	; o Sup Direita
		static CorpoHelicopteroCaracters + #2, #'l'	; l Inf Direita
		static CorpoHelicopteroCaracters + #3, #'d'	; d Inf Esquerda
    QuantidadeHelicopteros: var #1
	    static QuantidadeHelicopteros + #0, #5
	posHelicopteros: var #5
; ======================
; 	 Variaveis Barcos
; ======================
	TamanhoCorpoBarco: var #1
		static TamanhoCorpoBarco + #0, #2
	CorpoBarco: var #2
		static CorpoBarco + #0, #0
		static CorpoBarco + #1, #1
	CorpoBarcoCaracteres: var #2
		static CorpoBarcoCaracteres + #0, #'j'
		static CorpoBarcoCaracteres + #1, #'k'
	QuantidadeBarcos: var #1
		static QuantidadeBarcos + #0, #4
	posBarcos: var #4
; ======================
;         FLAGS
; ======================
    FlagMorto: var #1
        static FlagMorto + #0, #2000
    SCORE: var #1
    CoresScore: var #5
		static CoresScore + #0, #3072		; azul
		static CoresScore + #1, #3584		; aqua
		static CoresScore + #2, #2560		; verde claro
		static CoresScore + #3, #2816		; amarelo
		static CoresScore + #4, #2304		; vermelho
	ScoreHelicoptero: var #1
		static ScoreHelicoptero + #0, #5 
	ScoreBarco: var #1
		static ScoreBarco + #0, #5


contadorFrames: var #1						; Conta frames para operar

RAND: var #30
	static RAND + #0, #79
	static RAND + #1, #62
	static RAND + #2, #90
	static RAND + #3, #23
	static RAND + #4, #33
	static RAND + #5, #9
	static RAND + #6, #40
	static RAND + #7, #57
	static RAND + #8, #39
	static RAND + #9, #39
	static RAND + #10, #17
	static RAND + #11, #76
	static RAND + #12, #90
	static RAND + #13, #47
	static RAND + #14, #71
	static RAND + #15, #7
	static RAND + #16, #47
	static RAND + #17, #30
	static RAND + #18, #35
	static RAND + #19, #92
	static RAND + #20, #2
	static RAND + #21, #45
	static RAND + #22, #4
	static RAND + #23, #69
	static RAND + #24, #21
	static RAND + #25, #24
	static RAND + #26, #71
	static RAND + #27, #32
	static RAND + #28, #69
	static RAND + #29, #76
ContadorAleatorio: var #1

main:
	call ApagaTela
    call ResetaVariaveis
    call DesenhaCenario
    call DesenhaScore

	mainLoop:
		call Desenha
		call ConsomeCombustivel
		call Delay
		call Movimenta
		call IncrementaContadorFrames
		call GeraObjetosAleatoriamente
		jmp mainLoop

    halt

; retorna no r7 um número aleatorio
PegaNumeroAleatorio:
	push r0
	push r1

	load r0, ContadorAleatorio
	loadn r1, #RAND
	add r1, r0, r1

	loadi r7, r1

	inc r0			; r0 = (contadorAleatorio + 1) % 30
	loadn r1, #30	; garante que não vai dar acesso indevido
	mod r0, r0, r1

	store ContadorAleatorio, r0

	pop r1
	pop r0
	rts

ResetaVariaveis:
    loadn r0, #1020             ; linha 25, coluna 20
    store posNave, r0

    loadn r0, #30
	store combustivelNave, r0

	load r0, FlagMorto
	loadn r1, #posCombustiveis
	load r2, QuantidadeCombustiveis
	ResetaVariaveis_MataCombustivel:
		storei r1, r0
		inc r1
		dec r2
		jnz ResetaVariaveis_MataCombustivel

	load r0, FlagMorto
	loadn r1, #posHelicopteros
	load r2, QuantidadeHelicopteros
	ResetaVariaveis_MataHelicoptero:
		storei r1, r0
		inc r1
		dec r2
		jnz ResetaVariaveis_MataHelicoptero

	load r0, FlagMorto
	loadn r1, #posTiros
	load r2, QuantidadeTiros
	ResetaVariaveis_MataTiros:
		storei r1, r0
		inc r1
		dec r2
		jnz ResetaVariaveis_MataTiros

	load r0, FlagMorto
	loadn r1, #posBarcos
	load r2, QuantidadeBarcos
	ResetaVariaveis_MataBarcos:
		storei r1, r0
		inc r1
		dec r2
		jnz ResetaVariaveis_MataBarcos

	loadn r0, #0
	store ContadorAleatorio, r0
	store contadorFrames, r0
	store SCORE, r0

	rts

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

	call ApagaTela				; apaga toda tela

	call DesenhaScore

	loadn r0, #616
	loadn r1, #gameOverTexto
	loadn r2, #0
	call ImprimeStr

	loadn r0, #648
	loadn r1, #reiniciarTexto
	loadn r2, #0
	call ImprimeStr

	loadn r0, #'r'
	GameOver_Loop: 				; while(inchar != 'r')
		inchar r1
		cmp r0, r1
		jeq main
		jmp GameOver_Loop

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
	call DesenhaTodosTiros
	call DesenhaTodosBarcos

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
	call ApagaTodosTiros

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

Movimenta:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call MovimentaNave
	call MovimentaTodosTiros

	; helicopteros andam a cada 10 frames
	load r0, contadorFrames
	loadn r1, #10
	mod r1, r0, r1
	cz MovimentaTodosHelicopteros

	; barcos horizontal andam a cada 20 frames
	loadn r1, #20
	mod r1, r0, r1
	cz MovimentaTodosBarcosHorizontal

	; barcos (verticalmente) e combustiveis andam a cada 50 frames
	loadn r1, #50
	mod r1, r0, r1
	cz MovimentaTodosBarcosVertical

	loadn r1, #50
	mod r1, r0, r1
	cz MovimentaTodosObjetoCombustivel

	Movimenta_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

GeraObjetosAleatoriamente:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, contadorFrames
	loadn r1, #500
	mod r2, r0, r1
	cz GeraObjetoCombustivelAleatoriamente
	loadn r1, #50
	mod r2, r0, r1
	cz GeraHelicopteroAleatoriamente
	loadn r1, #150
	mod r2, r0, r1
	cz GeraBarcoAleatoriamente

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; r0 = Quantidade de score
AumentaScore:
	push r0
	push r1

	load r1, SCORE
	add r1, r1, r0
	store SCORE, r1

	call DesenhaScore

	pop r1
	pop r0
	rts

; r7 = cor retorno
PegaCorScore:
	push r0
	push r1

	load r0, SCORE
	loadn r1, #50
	div r0, r0, r1			; nivel = SCORE / r1

	loadn r1, #4			; ultimo indice da tabela
	cmp r0, r1
	jle PegaCorScore_Busca
	mov r0, r1			; passou do limite, fica no vermelho

	PegaCorScore_Busca:
		loadn r1, #CoresScore
		add r1, r1, r0
		loadi r7, r1

	pop r1
	pop r0
	rts

DesenhaScore:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call PegaCorScore
	mov r2, r7	; r2 é usado no imprime str

	loadn r0, #1120 			; Pos primeiro caracter
	loadn r1, #scoreTexto		; "SCORE:" Vai até a posição 1127
	call ImprimeStr
	loadn r0, #1128
	load r1, SCORE
	call ImprimeNumero

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

    load r0, posNave

    ; carrega o vetor corpo nave
    loadn r1, #CorpoNave
    loadn r2, #CorpoNaveCaracteres

    load r6, TamanhoCorpoNave

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

    load r0, posNave

    ; carrega o vetor corpo nave
    loadn r1, #CorpoNave

	; TODO - preencher com o fundo
    loadn r5, #' '			; Preenche com espaço branco!

    load r6, TamanhoCorpoNave

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
	jeq MovimentaNave_Esquerda
	loadn r1, #'d'
	cmp r0, r1
	jeq MovimentaNave_Direita
	loadn r1, #' '
	cmp r0, r1
	ceq Atirar
	jmp MovimentaNave_Fim

	MovimentaNave_Esquerda:
		call ApagaNave		; apago a nave se mexer

		load r0, posNave
		loadn r1, #1013		; Limite a esquerda

		dec r0 				; Movimenta para esquerda
		cmp r0, r1 			; if(posX < 1) return
		jle MovimentaNave_Fim
		store posNave, r0

		jmp MovimentaNave_Fim

	MovimentaNave_Direita:
		call ApagaNave

		load r0, posNave
		loadn r1, #1026		; Limite a direita

		inc r0 				; Movimenta para direita
		cmp r0, r1 			; if(posX > 39) return
		jgr MovimentaNave_Fim
		store posNave, r0
		jmp MovimentaNave_Fim

	MovimentaNave_Fim:
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
	loadn r1, #200
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

AumentarCombustivel:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, combustivelNave
	loadn r1, #5
	add r0, r0, r1

    loadn r1, #30
    cmp r0, r1
    jel AumentarCombustivel_Salva

    mov r0, r1

	AumentarCombustivel_Salva:
	    store combustivelNave, r0

	call DesenhaCombustivel

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; apaga e redesenha!
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

GeraObjetoCombustivelAleatoriamente:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	load r2, FlagMorto
	GeraObjetoCombustivelAleatoriamente_BuscaEspacoLivre:
		loadi r3, r0
		cmp r3, r2
		jeq GeraObjetoCombustivelAleatoriamente_CriaObjeto

		inc r0
		dec r1
		jnz GeraObjetoCombustivelAleatoriamente_BuscaEspacoLivre

	; chegou ate aqui nao teve posicao livre
	jmp GeraObjetoCombustivelAleatoriamente_Fim

	GeraObjetoCombustivelAleatoriamente_CriaObjeto:
		; r0 end do obj livre

		call PegaNumeroAleatorio		; gera um numero aleatorio em r7
		loadn r2, #15					; 13 < x < 28
		mod r2, r7, r2
		loadn r3, #13
		add r2, r2, r3

		storei r0, r2

	GeraObjetoCombustivelAleatoriamente_Fim:
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

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	load r2, CombustivelObjetoCaracter

	DesenhaObjetoCombustivel_Loop:
		loadi r3, r0

		; Checa se o combustivel está morto
		; se estiver morto não tem que desenahr
		load r5, FlagMorto
		cmp r3, r5
		jeq DesenhaObjetoCombustivel_Loop_Fim

		outchar r2, r3

		DesenhaObjetoCombustivel_Loop_Fim:
			inc r0
			dec r1
			jnz DesenhaObjetoCombustivel_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ApagaTodosObjetoCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	loadn r2, #' '

	ApagaTodosObjetoCombustivel_Loop:
		loadi r3, r0

		; checa se ja morreu
		load r4, FlagMorto
		cmp r3, r4
		jeq ApagaTodosObjetoCombustivel_Loop_Fim

		outchar r2, r3					; Apaga o combustivel

		ApagaTodosObjetoCombustivel_Loop_Fim:
			inc r0
			dec r1
			jnz ApagaTodosObjetoCombustivel_Loop

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

	call ApagaTodosObjetoCombustivel

	loadn r0, #posCombustiveis
	load r2, QuantidadeCombustiveis

	MovimentaTodosObjetoCombustivel_Loop:
		loadi r3, r0

		; checa se morreu
		load r4, FlagMorto
		cmp r3, r4
		jeq MovimentaTodosObjetoCombustivel_Loop_Fim

		loadn r4, #40
		add r3, r3, r4

		loadn r5, #1120          ; limite (não invadir a barra de fuel)
		cmp r3, r5
		jle MovimentaTodosObjetoCombustivel_Loop_Salva

		load r3, FlagMorto

		MovimentaTodosObjetoCombustivel_Loop_Salva:
			storei r0, r3
		MovimentaTodosObjetoCombustivel_Loop_Fim:
			inc r0
			dec r2
			jnz MovimentaTodosObjetoCombustivel_Loop

	call ChecaColisaoTodosObjetoCombustivel

	MovimentaTodosObjetoCombustivel_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ChecaColisaoTodosObjetoCombustivel:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	ChecaColisaoTodosObjetoCombustivel_Loop:
	    loadi r2, r0

		load r3, FlagMorto
		cmp r2, r3
		jeq ChecaColisaoTodosObjetoCombustivel_Loop_Fim

        load r3, posNave
	    loadn r4, #CorpoNave
	    load r5, TamanhoCorpoNave
		ChecaColisaoTodosObjetoCombustivel_Loop_2:
		    loadi r6, r4
			add r6, r6, r3
			cmp r2, r6

			jne ChecaColisaoTodosObjetoCombustivel_Loop_2_Fim

            ceq AumentarCombustivel
            ceq MataObjetoCombustivel
            jmp ChecaColisaoTodosObjetoCombustivel_Fim

            ChecaColisaoTodosObjetoCombustivel_Loop_2_Fim:
                inc r4
                dec r5
                jnz ChecaColisaoTodosObjetoCombustivel_Loop_2

		ChecaColisaoTodosObjetoCombustivel_Loop_Fim:
		    inc r0
		    dec r1
			jnz ChecaColisaoTodosObjetoCombustivel_Loop

    ChecaColisaoTodosObjetoCombustivel_Fim:
        pop r6
    	pop r5
    	pop r4
    	pop r3
    	pop r2
    	pop r1
    	pop r0
    	rts


; ==================
; 	FUNÇÕES ATIRAR
; ==================

Atirar:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, posNave		; o tiro nasce uma linha acima da nave
	loadn r1, #40
	sub r0, r0, r1

	load r2, FlagMorto
	load r3, QuantidadeTiros
	loadn r4, #posTiros

	Atirar_ProcuraPosicaoLivre:
		loadi r5, r4
		cmp r5, r2
		jeq Atirar_Salvar

		inc r4
		dec r3
		jnz Atirar_ProcuraPosicaoLivre

    jmp Atirar_Fim          ; chegou aqui porque não tem espaço livre

	Atirar_Salvar:			; quando chegar aqui o r4 tem o endereço do tiro livre
		storei r4, r0

    Atirar_Fim:
    	pop r6
    	pop r5
    	pop r4
    	pop r3
    	pop r2
    	pop r1
    	pop r0
    	rts

DesenhaTodosTiros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posTiros
	load r2, CorpoTiroCaracter
	load r3, QuantidadeTiros
	DesenhaTodosTiros_Loop:
		loadi r4, r0
		load r5, FlagMorto
		cmp r4, r5
		jeq DesenhaTodosTiros_Loop_Fim

		outchar r2, r4

		DesenhaTodosTiros_Loop_Fim:
			inc r0
			dec r3
			jnz DesenhaTodosTiros_Loop

	DesenhaTodosTiros_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ApagaTodosTiros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posTiros

	loadn r2, #' '
	load r3, QuantidadeTiros

	ApagaTodosTiros_Loop:
		loadi r4, r0
		load r5, FlagMorto
		cmp r4, r5
		jeq ApagaTodosTiros_Loop_Fim

		outchar r2, r4

		ApagaTodosTiros_Loop_Fim:
			inc r0
			dec r3
			jnz ApagaTodosTiros_Loop

	ApagaTodosTiros_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

MovimentaTodosTiros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call ApagaTodosTiros

	loadn r0, #posTiros
    load r1, FlagMorto
	load r2, QuantidadeTiros

	MovimentaTodosTiros_Loop:
		loadi r3, r0
		cmp r3, r1
		jeq MovimentaTodosTiros_Loop_Fim

		loadn r4, #40
		sub r3, r3, r4          ; sobe uma linha

	    ; COMENTÁRIO
	    ; Não sei se é o comportamento esperado, porém
		; no simulador que eu uso, a CPU do ICMC quando
		; da negativo fica igual a zero, por isso estou
		; comparando com 0 aqui em baixo :P

        loadn r4, #0
        cmp r3, r4
		jne MovimentaTodosTiros_Salvar

		MovimentaTodosTiros_Matar:
			mov r3, r1
		MovimentaTodosTiros_Salvar:
			storei r0, r3
		MovimentaTodosTiros_Loop_Fim:
			inc r0
			dec r2
			jnz MovimentaTodosTiros_Loop

	call ChecaColisaoTodosTiros

	MovimentaTodosTiros_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ChecaColisaoTodosTiros:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posTiros
	load r1, QuantidadeTiros

	ChecaColisaoTodosTiros_Loop:
        loadi r2, r0
        load r3, FlagMorto
		cmp r2, r3
		jeq ChecaColisaoTodosTiros_Loop_Fim

		; CHECA COLISAO DO TIRO COM HELICOPTERO
		push r0
		mov r0, r2  	; r0 guarda a posicao do tiro em questao
		call ChecaColisaoTiroHelicopteros
		pop r0

		; se o retorno da funcao for 1, significa
		; que algum helicoptero foi morto
		; sendo assim tem que matar o tiro!
		loadn r3, #1
		cmp r7, r3
		jeq ChecaColisaoTodosTiros_Loop_MatarTiro

		; CHECA COLISAO DO TIRO COM COMBUSTÍVEL
		push r0
		mov r0, r2
		call ChecaColisaoTiroCombutiveis
		pop r0

		cmp r7, r3
		jeq ChecaColisaoTodosTiros_Loop_MatarTiro

		; CHECA COLISAO DO TIRO COM BARCO
		push r0
		mov r0, r2
		call ChecaColisaoTiroBarcos
		pop r0

		cmp r7, r3
		jeq ChecaColisaoTodosTiros_Loop_MatarTiro

		jmp ChecaColisaoTodosTiros_Loop_Fim

    ChecaColisaoTodosTiros_Loop_MatarTiro:
        load r2, FlagMorto
        storei r0, r2

		ChecaColisaoTodosTiros_Loop_Fim:
		  inc r0
			dec r1
			jnz ChecaColisaoTodosTiros_Loop

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts


; r0 posicao do tiro atual
; r7 retorna se matou algum helicoptero
ChecaColisaoTiroHelicopteros:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r7, #0        ; comeca com não

	loadn r1, #posHelicopteros
	load r2, QuantidadeHelicopteros

	ChecaColisaoTiroHelicopteros_Loop:
	    loadi r3, r1
		load r4, FlagMorto
		cmp r3, r4
		jeq ChecaColisaoTiroHelicopteros_Loop_Fim

        loadn r4, #CorpoHelicoptero
        load r5, TamanhoCorpoHelicoptero
		ChecaColisaoTiroHelicopteros_Loop_Loop:
		    loadi r6, r4
			add r6, r3, r6
			cmp r0, r6

			jeq ChecaColisaoTiroHelicopteros_Loop_Matou

			inc r4
			dec r5
			jnz ChecaColisaoTiroHelicopteros_Loop_Loop

    ; se chegou aqui não atingiu em momento algum!
    jmp ChecaColisaoTiroHelicopteros_Loop_Fim

	ChecaColisaoTiroHelicopteros_Loop_Matou:
		push r0
		mov r0, r1
		call MataHelicoptero
	    pop r0

	    loadn r7, #1

	ChecaColisaoTiroHelicopteros_Loop_Fim:
	    inc r1
		dec r2
		jnz ChecaColisaoTiroHelicopteros_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; r0 - pos do tiro
; r7 - retorno se algum morreu
ChecaColisaoTiroCombutiveis:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    loadn r7, #0

    loadn r1, #posCombustiveis
	load r2, QuantidadeCombustiveis
	ChecaColisaoTiroCombutiveis_Loop:
	    loadi r3, r1
		load r4, FlagMorto
		cmp r3, r4
		jeq ChecaColisaoTiroCombutiveis_Loop_Fim

        cmp r0, r3
        jne ChecaColisaoTiroCombutiveis_Loop_Fim

        push r1
        loadn r1, #5 		; raio da explosao
        call ExplosaoMataObjetos
        pop r1

        push r0
        mov r0, r1
        call MataObjetoCombustivel
        pop r0

        loadn r7, #1

    	ChecaColisaoTiroCombutiveis_Loop_Fim:
    	    inc r1
    		dec r2
    		jnz ChecaColisaoTiroCombutiveis_Loop

    pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; r0 = endereço do y
MataObjetoCombustivel:
	push r0
	push r1

	call ApagaTodosObjetoCombustivel

	load r1, FlagMorto
	storei r0, r1

	pop r1
	pop r0
	rts


; r0 = pos inicial
; r1 = raio
ExplosaoMataObjetos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r2, #posHelicopteros
	load r3, QuantidadeHelicopteros
	ExplosaoMataObjetos_Helicopteros:
		loadi r4, r2

		load r5, FlagMorto
		cmp r4, r5
		jeq ExplosaoMataObjetos_Helicopteros_Fim

		mov r7, r4			; parametro no r7
		call DentroDoRaio	; retorno no r7

		loadn r5, #1
		cmp r7, r5
		jne ExplosaoMataObjetos_Helicopteros_Fim

		ExplosaoMataObjetos_Helicopteros_Matou:
		    push r0
            mov r0, r2
            call MataHelicoptero
		    pop r0

		ExplosaoMataObjetos_Helicopteros_Fim:
			inc r2
			dec r3
			jnz ExplosaoMataObjetos_Helicopteros

	loadn r2, #posBarcos
	load r3, QuantidadeBarcos
	ExplosaoMataObjetos_Barcos:
		loadi r4, r2

		load r5, FlagMorto
		cmp r4, r5
		jeq ExplosaoMataObjetos_Barcos_Fim

		mov r7, r4
		call DentroDoRaio

		loadn r5, #1
		cmp r7, r5
		jne ExplosaoMataObjetos_Barcos_Fim

		ExplosaoMataObjetos_Barcos_Matou:
			push r0
			mov r0, r2
			call MataBarco
			pop r0

		ExplosaoMataObjetos_Barcos_Fim:
			inc r2
			dec r3
			jnz ExplosaoMataObjetos_Barcos

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; r0 = pos inicial
; r1 = raio
; r7 = segunda posicao
; retorno 0/1 no r7
DentroDoRaio:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r6, #40
	div r3, r0, r6	; y da primeira posicao
	mod r2, r0, r6	; x da primeira posicao

	div r5, r7, r6	; y da segunda posicao
	mod r4, r7, r6	; x da segunda posicao

	cmp r3, r5
	jle DentroDoRaio_Y2Maior

	sub r6, r3, r5
	jmp DentroDoRaio_X

	DentroDoRaio_Y2Maior:
		sub r6, r5, r3

	DentroDoRaio_X:
		cmp r2, r4
		jle DentroDoRaio_X2Maior

		sub r7, r2, r4

		jmp DentroDoRaio_Calcula

		DentroDoRaio_X2Maior:
			sub r7, r4, r2

	DentroDoRaio_Calcula:	; r6 distancia dos y
							; r7 distancia dos x
		mul r6, r6, r6		; r6 ao quadrado
		mul r7, r7, r7		; r7 ao quadrado
		mul r1, r1, r1		; raio ao quadrado
		add r6, r6, r7		; r6 = (r6)^2 + (r7)^2

		cmp r6, r1
		jle DentroDoRaio_Dentro
		jgr DentroDoRaio_Fora

	DentroDoRaio_Dentro:
		loadn r7, #1
		jmp DentroDoRaio_Fim
	DentroDoRaio_Fora:
		loadn r7, #0
		jmp DentroDoRaio_Fim

	DentroDoRaio_Fim:
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

GeraHelicopteroAleatoriamente:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posHelicopteros
	load r1, QuantidadeHelicopteros
	load r2, FlagMorto
	GeraHelicopteroAleatoriamente_BuscaPosicaoLivre:
		loadi r3, r0
		cmp r3, r2
		jeq GeraHelicopteroAleatoriamente_CriaHelicoptero

		inc r0
		dec r1
		jnz GeraHelicopteroAleatoriamente_BuscaPosicaoLivre

	; chegou aqui, ou seja, não tem posicao livre!
	jmp GeraHelicopteroAleatoriamente_Fim

	GeraHelicopteroAleatoriamente_CriaHelicoptero:
		; r0 -> end da primeira posicao livre
		call PegaNumeroAleatorio			; numero aleatorio em r7

		loadn r2, #15						; posicao do x 13 < x < 28
		mod r2, r7, r2
		loadn r3, #13
		add r2, r2, r3

		storei r0, r2                       ; todo helicoptero começa na linha 0

	GeraHelicopteroAleatoriamente_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

DesenhaTodosHelicopteros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #posHelicopteros
	load r1, QuantidadeHelicopteros

	DesenhaTodosHelicopteros_Loop:
	    loadi r2, r0

        load r3, FlagMorto
        cmp r2, r3
        jeq DesenhaTodosHelicopteros_Loop_Fim

        loadn r3, #CorpoHelicoptero
        loadn r4, #CorpoHelicopteroCaracters
        load r5, TamanhoCorpoHelicoptero
        DesenhaTodosHelicopteros_Loop_Loop:
            loadi r6, r3
            add r6, r6, r2

            loadi r7, r4
            outchar r7, r6

            inc r3
            inc r4
            dec r5
            jnz DesenhaTodosHelicopteros_Loop_Loop

        DesenhaTodosHelicopteros_Loop_Fim:
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

; r0 endereco do helicoptero em questao
MataHelicoptero:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    ; apago todos os helicopteros da tela antes de perder a posicao dele
    ; os demais serao redesenhados naturalmente
	call ApagaTodosHelicopteros

	load r1, FlagMorto
	storei r0, r1

	load r0, ScoreHelicoptero 		; pontuacao por matar helicoptero
	call AumentaScore

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

	call ApagaTodosHelicopteros			; helicoptero vai mover, então apago ele

	loadn r0, #posHelicopteros
	load r1, QuantidadeHelicopteros

	MovimentaTodosHelicopteros_Loop:
		loadi r3, r0
        load r4, FlagMorto
		cmp r3, r4
		jeq MovimentaTodosHelicopteros_Loop_Fim

        loadn r4, #40
        add r3, r3, r4  ; desce uma linha

        ; lembrar que o corpo do helicopter ocupa 4 quadrados
        ; então considerando a linha de combustivel não pode
        ; passar da linha 27, ou seja, posicao 1080
        loadn r5, #1080 ; limite vertical

		cmp r3, r5		; if(helicoptero passou limites) matar()
		jgr MovimentaTodosHelicopteros_Loop_Matar

		MovimentaTodosHelicopteros_Loop_Salvar:
			storei r0, r3
            jmp MovimentaTodosHelicopteros_Loop_Fim

		MovimentaTodosHelicopteros_Loop_Matar:
			call MataHelicoptero
			jmp MovimentaTodosHelicopteros_Loop_Fim

		MovimentaTodosHelicopteros_Loop_Fim:
			inc r0
			dec r1
			jnz MovimentaTodosHelicopteros_Loop

	call ChecaColisaoTodosHelicopteros

	MovimentaTodosHelicopteros_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

ChecaColisaoTodosHelicopteros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

    loadn r0, #posHelicopteros
    load r1, QuantidadeHelicopteros
    ChecaColisaoTodosHelicopteros_Loop:
        loadi r2, r0
        load r3, FlagMorto
        cmp r2, r3
        jeq ChecaColisaoTodosHelicopteros_Loop_Fim

        loadn r3, #CorpoHelicoptero
        load r4, TamanhoCorpoHelicoptero
        ChecaColisaoTodosHelicopteros_Loop2:
            loadi r5, r3
            add r5, r5, r2  ; offset adicionado

            loadn r6, #CorpoNave
            load r7, TamanhoCorpoNave
            ChecaColisaoTodosHelicopteros_Loop3:
                push r0          ; não consegui não fazer spill aqui
                push r1          ; perdoem-me

                load r0, posNave
                loadi r1, r6
                add r0, r0, r1
                cmp r0, r5

                jeq GameOver   ; COLIDIU
                ; o próprio gameover reseta o SP, então fehcou os guri

                pop r1
                pop r0

                inc r6
                dec r7
                jnz ChecaColisaoTodosHelicopteros_Loop3

            inc r3
            dec r4
            jnz ChecaColisaoTodosHelicopteros_Loop2

        ChecaColisaoTodosHelicopteros_Loop_Fim:
            inc r0
            dec r1
            jnz ChecaColisaoTodosHelicopteros_Loop

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

	loadn r0, #posHelicopteros
	load r1, QuantidadeHelicopteros

	ApagaTodosHelicopteros_Loop:
	    loadi r2, r0

        load r3, FlagMorto
        cmp r2, r3
        jeq ApagaTodosHelicopteros_Loop_Fim

        loadn r3, #CorpoHelicoptero
        loadn r4, #' '
        load r5, TamanhoCorpoHelicoptero

        ApagaTodosHelicopteros_Loop_Loop:
            loadi r6, r3
            add r6, r6, r2

            outchar r4, r6

            inc r3
            dec r5
            jnz ApagaTodosHelicopteros_Loop_Loop

        ApagaTodosHelicopteros_Loop_Fim:
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

; ======================
; 	  Funções Barcos
; ======================

GeraBarcoAleatoriamente:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, QuantidadeBarcos
	loadn r1, #posBarcos
	load r2, FlagMorto

	GeraBarcoAleatoriamente_BuscaPosicao:
		loadi r3, r1
		cmp r3, r2
		jeq GeraBarcoAleatoriamente_Cria

		inc r1
		dec r0
		jnz GeraBarcoAleatoriamente_BuscaPosicao

	; Chegou aqui então não tem posição livre
	jmp GeraBarcoAleatoriamente_Fim

	GeraBarcoAleatoriamente_Cria:
		call PegaNumeroAleatorio	; numero aleatorio em r7

		loadn r3, #2
		mod r3, r1, r3 				; barcos pares nascem na esquerda
									; barcos impares nascem na direita
		jnz GeraBarcoAleatoriamente_Cria_Direita

		GeraBarcoAleatoriamente_Cria_Esquerda:
			loadn r2, #12
			jmp GeraBarcoAleatoriamente_Cria_Salva
		GeraBarcoAleatoriamente_Cria_Direita:
			loadn r2, #26

		GeraBarcoAleatoriamente_Cria_Salva:
			storei r1, r2

	GeraBarcoAleatoriamente_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
	    rts

DesenhaTodosBarcos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, QuantidadeBarcos
	loadn r1, #posBarcos

	DesenhaTodosBarcos_Loop1:
		loadi r2, r1
		load r3, FlagMorto
		cmp r2, r3
		jeq DesenhaTodosBarcos_Loop1_Fim

		; COMENTÁRIO
		; Essa parte ta zero generalista, mas
		; acho que desse jeito fica bem mais
		; simples, zero necessidade de fazer
		; um outro loop

		loadn r3, #CorpoBarcoCaracteres	; carrega o caracter
		loadi r4, r3
		outchar r4, r2
		inc r2							; posicao do lado
		inc r3 							; proximo caracter
		loadi r4, r3
		outchar r4, r2

		DesenhaTodosBarcos_Loop1_Fim:
			inc r1
			dec r0
			jnz DesenhaTodosBarcos_Loop1

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

ApagaTodosBarcos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, QuantidadeBarcos
	loadn r1, #posBarcos

	ApagaTodosBarcos_Loop1:
		loadi r2, r1
		load r3, FlagMorto
		cmp r2, r3
		jeq ApagaTodosBarcos_Loop1_Fim

		loadn r3, #' '
		outchar r3, r2
		inc r2							; posicao do lado
		outchar r3, r2

		ApagaTodosBarcos_Loop1_Fim:
			inc r1
			dec r0
			jnz ApagaTodosBarcos_Loop1

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

MovimentaTodosBarcosVertical:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call ApagaTodosBarcos

	load r0, QuantidadeBarcos
	loadn r1, #posBarcos
	MovimentaTodosBarcosVertical_Loop:
		loadi r2, r1
		load r3, FlagMorto
		cmp r2, r3
		jeq MovimentaTodosBarcosVertical_Loop_Fim

		loadn r3, #40 		; tamanho da linha
		add r2, r2, r3

		; Checa se o barco passou do limite vertical
		; se passou mata ele

		div r3, r2, r3 		; ve em que linha esta
		loadn r4, #26 		; limite vertical
		cmp r3, r4
		jgr MovimentaTodosBarcosVertical_Loop_Mata

		storei r1, r2

		jmp MovimentaTodosBarcosVertical_Loop_Fim

		MovimentaTodosBarcosVertical_Loop_Mata:
			load r3, FlagMorto
			storei r1, r3
		MovimentaTodosBarcosVertical_Loop_Fim:
			inc r1
			dec r0
			jnz MovimentaTodosBarcosVertical_Loop

	call ChecaColisaoTodosBarcos

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

MovimentaTodosBarcosHorizontal:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	call ApagaTodosBarcos

	loadn r0, #posBarcos
	load r1, QuantidadeBarcos
	MovimentaTodosBarcosHorizontal_Loop:
		loadi r2, r0
		load r3, FlagMorto
		cmp r2, r3
		jeq MovimentaTodosBarcosHorizontal_Loop_Fim

		loadn r3, #40
		div r3, r2, r3 		; calcula a linha que o barco está
		loadn r4, #15 		; começa a andar a partir da linha 15
		cmp r3, r4
		jle MovimentaTodosBarcosHorizontal_Loop_Fim

		loadn r3, #2 		; barcos pares andam para direita
		mod r3, r0, r3
		jz MovimentaTodosBarcosHorizontal_Loop_Direita

		MovimentaTodosBarcosHorizontal_Loop_Esquerda:
			dec r2			; anda para esquerda
			loadn r3, #40
			mod r3, r2, r3 	; calcula o x do barco
			loadn r4, #12 	; limite a esquerda
			cmp r3, r4
			jgr MovimentaTodosBarcosHorizontal_Loop_Salva
			jmp MovimentaTodosBarcosHorizontal_Loop_Fim

		MovimentaTodosBarcosHorizontal_Loop_Direita:
			inc r2			; anda para direita
			loadn r3, #40
			mod r3, r2, r3 	; calcula o x do barco
			loadn r4, #26 	; limite a direita
			cmp r3, r4
			jle MovimentaTodosBarcosHorizontal_Loop_Salva
			jmp MovimentaTodosBarcosHorizontal_Loop_Fim

		MovimentaTodosBarcosHorizontal_Loop_Salva:
			;	Ver com o simões isso aqui
			;	parece que eu compliquei
			; 	mais do que precisa

			;	push r0
			;	mov r0, r2
			;	call PosicaoEstaLivre
			;	pop r0
			;	loadn r3, #1 	; no r7 tem o retorno da subrotina
			;	cmp r3, r7		; se a posicao ta ocupada, ele não se move!
			;	jeq MovimentaTodosBarcosHorizontal_Loop_Fim

			storei r0, r2
		MovimentaTodosBarcosHorizontal_Loop_Fim:
			inc r0
			dec r1
			jnz MovimentaTodosBarcosHorizontal_Loop

	call ChecaColisaoTodosBarcos

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; r0 = endereço do barco em questão
MataBarco:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	; apagar todos os barcos antes de eu perder
	; a posição desse barco
	call ApagaTodosBarcos

	load r1, FlagMorto
	storei r0, r1

	load r0, ScoreBarco
	call AumentaScore

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

ChecaColisaoTodosBarcos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, QuantidadeBarcos
	loadn r1, #posBarcos

	ChecaColisaoTodosBarcos_Loop1:
		loadi r2, r1
		load r3, FlagMorto
		cmp r2, r3
		jeq ChecaColisaoTodosBarcos_Loop1_Fim

		loadn r3, #CorpoNave
		load r4, TamanhoCorpoNave

		ChecaColisaoTodosBarcos_Loop2:
			load r5, posNave
			loadi r6, r3
			add r5, r5, r6

			cmp r5, r2
			jeq GameOver 	; bateu a parte esquerda do barco
			inc r2
			cmp r5, r2
			jeq GameOver 	; bateu a parte direita do barco

			dec r2 			; restaura o r2 para o próximo loop

			inc r3
			dec r4
			jnz ChecaColisaoTodosBarcos_Loop2

		ChecaColisaoTodosBarcos_Loop1_Fim:
			inc r1
			dec r0
			jnz ChecaColisaoTodosBarcos_Loop1

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; r0 = posicao do tiro em questao
ChecaColisaoTiroBarcos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r7, #0

	loadn r1, #posBarcos
	load r2, QuantidadeBarcos
	ChecaColisaoTiroBarcos_Loop:
		loadi r3, r1
		load r4, FlagMorto
		cmp r3, r4
		jeq ChecaColisaoTiroBarcos_Loop_Fim

		cmp r3, r0					; parte esquerda
		jeq ChecaColisaoTiroBarcos_Loop_Acertou
		inc r3 						; incrementa para olhar a direita
		cmp r3, r0
		jeq ChecaColisaoTiroBarcos_Loop_Acertou

		jmp ChecaColisaoTiroBarcos_Loop_Fim		; se não atingiu nenhuma das duas continue


		ChecaColisaoTiroBarcos_Loop_Acertou:
			push r0
			mov r0, r1
			call MataBarco
			pop r0

			loadn r7, #1 					; passa para a função que algum barco morreu
			jmp ChecaColisaoTiroBarcos_Fim 	; não precisa continuar checando

		ChecaColisaoTiroBarcos_Loop_Fim:
			inc r1
			dec r2
			jnz ChecaColisaoTiroBarcos_Loop

	ChecaColisaoTiroBarcos_Fim:
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
	    rts

; r0 = posição aboluta a checar
; r7 = retorno 0/1
PosicaoEstaLivre:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r7, #0

	loadn r1, #posHelicopteros
	load r2, QuantidadeHelicopteros
	PosicaoEstaLivre_Helicopteros:
		loadi r3, r1
		load r4, FlagMorto
		cmp r3, r4
		jeq PosicaoEstaLivre_Helicopteros_Fim

		loadn r4, #CorpoHelicoptero
		load r5, QuantidadeHelicopteros
		PosicaoEstaLivre_Helicopteros_Loop:
			loadi r6, r4
			add r6, r3, r6
			cmp r0, r6
			jeq PosicaoEstaLivre_Ocupada

			inc r4
			dec r5
			jnz PosicaoEstaLivre_Helicopteros_Loop


		PosicaoEstaLivre_Helicopteros_Fim:
			inc r1
			dec r2
			jnz PosicaoEstaLivre_Helicopteros

	loadn r1, #posCombustiveis
	load r2, QuantidadeCombustiveis
	PosicaoEstaLivre_Combustivel:
		loadi r3, r1
		load r4, FlagMorto
		cmp r3, r4
		jeq PosicaoEstaLivre_Combustivel_Fim

		cmp r3, r0
		jeq PosicaoEstaLivre_Ocupada

		PosicaoEstaLivre_Combustivel_Fim:
			inc r1
			dec r2
			jnz PosicaoEstaLivre_Combustivel

	jmp PosicaoEstaLivre_Fim

	PosicaoEstaLivre_Ocupada:
		loadn r7, #1
	PosicaoEstaLivre_Fim:
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
    loadn r1, #10000
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

; r0 = posicao
; r1 = numero
; r2 = cor
ImprimeNumero:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	; os registradores são 16 bits
	; então o limite é 65335, logo
	; eu vou ir dividindo por 10^n
	; e ir imprimindo

	loadn r3, #5
	loadn r4, #10000
	ImprimeNumero_Loop:
		div r5, r1, r4	; o numero r5 vai ser impresso
		mod r1, r1, r4	; para o próximo loop

		loadn r6, #'0'
		add r5, r5, r6	; transforma em ASCII
		add r5, r5, r2 	; coloca a cor

		outchar r5, r0

		loadn r6, #10
		div r4, r4, r6

		inc r0
		dec r3
		jnz ImprimeNumero_Loop

	pop r6
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

; ====================
;       CENÁRIO
; ====================

; basicamente só desenha grama em toda tela da coluna 0 a 12
; até a ultima linha que tem a resenha do combustivel
DesenhaCenario:
    push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #2599     ; ' verde grama
	loadn r1, #0        ; pos inicial
	loadn r2, #28       ; ultima linha
	loadn r4, #0        ; linha atual

	DesenhaCenario_Loop1:
	    inc r4
	    loadn r3, #12   ; 12 colunas
        DesenhaCenario_Loop1_Loop:
    		outchar r0, r1
            inc r1
            dec r3
            jnz DesenhaCenario_Loop1_Loop
        loadn r5, #40
        mul r1, r4, r5
        dec r2
        jnz DesenhaCenario_Loop1

    loadn r1, #28        ; pos inicial
	loadn r2, #28       ; ultima linha
	loadn r4, #0        ; linha atual

	DesenhaCenario_Loop2:
	    inc r4
	    loadn r3, #12   ; 12 colunas
        DesenhaCenario_Loop2_Loop:
    		outchar r0, r1
            inc r1
            dec r3
            jnz DesenhaCenario_Loop2_Loop
        loadn r5, #40
        mul r1, r4, r5
        loadn r5, #28
        add r1, r1, r5
        dec r2
        jnz DesenhaCenario_Loop2

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts


jmp main
