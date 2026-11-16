jmp inicio

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
		static CorpoTiroCaracter + #0, #'i'            ; i vermelho claro
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

inicio:
	call ImprimeTelaInicio
	loadn r1, #' '
	inicio_loop:
		inchar r0
		cmp r1, r0
		jne inicio_loop
main:
	call ApagaTela
    call ResetaVariaveis
    call DesenhaCenario
    call DesenhaScore

	mainLoop:
		call Desenha
		call Delay
		call Movimenta
		call IncrementaContadorFrames
		call GeraObjetosAleatoriamente
		jmp mainLoop

    halt

; ========== PegaNumeroAleatorio ==========
;  	Pega um número do vetor RAND
;	Incrementa o contador aleatório
;	Retorna o número aleatório no r7
; =========================================
PegaNumeroAleatorio:
	push r0	; guarda o contador aleatório que vai iterando pelos números
	push r1	; guarda o endereço do número a ser resgatado

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

; ============ ResetaVariaveis ============
;	Reseta todas as variavéis do programa
; 	Utilizada pela main para não dar pro-
;	blemas de persistência após reset.
; =========================================
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

; ======= IncrementaContadorFrames ========
;	Incrementa o contador de frames, que
;	serve de guia para as movimentações do
;	jogo, chamado pela main no fim do loop
; =========================================
IncrementaContadorFrames:
	push r0

	load r0, contadorFrames
	inc r0
	store contadorFrames, r0

	pop r0
    rts

; =============== GameOver ================
;	Chamada sempre que o jogador morrer
;	Ela reseta o stack pointer! 
; 	Jogador saí daqui ao apertar 'r'
; =========================================
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

; ================ Desenha ================
;	Desenha todos objetos na tela, chamando
;	as respectivas subrotinas
; =========================================
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

; ================= Apaga =================
;	Apaga os objetos da tela, chamando as
;	respectivas subrotinas.
;	Não está sendo utilizada! Pois, estamos
;	Apagando os objetos ao move-los
;	para evitar flickering
; =========================================
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

; ================ Movimenta ===============
;	Movimenta todos os objetos na tela,
;	chamando as respectivas subrotinas.
;	A função movimenta mapeia de quanto em
;	quanto tempo os objetos movem!
;	Utiliza contadorFrames para tanto.
;	
;	if(contadorFrames % tempo == 0)
;		movimentar();
; =========================================
Movimenta:
	push r0	; Contador frames atual
	push r1	; Tempos de movimentação de cada objeto

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

	loadn r1, #200
	mod r1, r0, r1
	cz ConsomeCombustivel

	Movimenta_Fim:
		pop r1
		pop r0
		rts

; ======== GeraObjetosAleatoriamente ======
;	Gera todos os objetos na tela, chamando
;	as respectivas subrotinas. Assim como a
;	Movimenta se baseia no contador frames,
; 	com a mesma lógica.
;
;	if(contadorFrames % tempo == 0)
;		gerar();
; =========================================
GeraObjetosAleatoriamente:
	push r0	; contador frames atual
	push r1	; tempo de cada geração

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

	pop r1
	pop r0
	rts

; ============== AumentaScore =============
;	Aumenta o score do jogador, que está
;	na variável SCORE.
;	r0 -> parâmetro quantidade de score
; =========================================
AumentaScore:
	push r0	; quantidade de score
	push r1	; score atual

	load r1, SCORE
	add r1, r1, r0
	store SCORE, r1

	call DesenhaScore

	pop r1
	pop r0
	rts

; ============== PegaCorScore =============
;	O vetor CoresScore guarda uma lista
;	de cores. Essa função escolhe a cor
; 	com base na pontuação do jogador
;	níveis a cada 50 pontos.
;	r7 -> retorna a cor a ser usada
; =========================================
PegaCorScore:
	push r0	; Score atual -> nivel atual
	push r1	; distância entre níveis -> quantidade de cores 

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

; ============== DesenhaScore =============
;	Desenha o Score na tela, com a função
;	imprimeStr e ImprimeNumero, ambas rece-
;	bem nos seguintes registradores:
;		r0: posição inicial
;		r1: informação a imprimir
;		r2: cor <- PegaCorScore
;
;	Resultado na tela: canto inferior esq.
;	SCORE: 00123
; =========================================
DesenhaScore:
	push r0	; posicao de impressao
	push r1	; endereço do texto -> score para imprimir
	push r2 ; cor para impressão

	call PegaCorScore
	mov r2, r7	; r2 é usado no imprime str

	loadn r0, #1120 			; Pos primeiro caracter
	loadn r1, #scoreTexto		; "SCORE:" Vai até a posição 1127
	call ImprimeStr
	loadn r0, #1128
	load r1, SCORE
	call ImprimeNumero

	pop r2
	pop r1
	pop r0
	rts

; ============== DesenharNave =============
;	Desenha a nave na tela. Usa a posição
;	da nave e soma os offsets do corpo
;	nave e imprime o respectivo caracter
; =========================================
DesenharNave:
    push r0	; pos absoluta da cabeça da nave
	push r1	; endereço vetor corpo nave
	push r2 ; endereço vetor caracteres da nave
	push r3 ; posição relativa de uma parte da nave
	push r4	; valor atual do r1 -> um offset da nave
	push r5	; valor atual do r2 -> caracter para imprimir
	push r6	; tamanho do corpo nave para controlar o loop

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

; =============== ApagaNave ===============
;	Apaga a nave da tela, baseado na pos
;	atual da nave. Coloca um espaço branco
;	em cada parte da nave.
;	USO: antes de mover a nave! Senão,
;	vai apagar o lugar errado.
; =========================================
ApagaNave:
	push r0	; pos absoluta da cabeça da nave
	push r1	; vetor corpo nave
	push r2 ; espaço em branco -> borracha
	push r3 ; Tamanho do corpo da nave para controlar o loop
	push r4	; posicao com offset
	push r5	; valor do r1 -> offset

    load r0, posNave

    loadn r1, #CorpoNave

    loadn r2, #' '			; Preenche com espaço branco!

    load r3, TamanhoCorpoNave

    ApagaNaveLoop:
        mov r4, r0 			; posicao absoluta em r3
        loadi r5, r1 		; r4 = offset relativo
        add r4, r4, r5

        outchar r2, r4

        inc r1
        dec r3
        jnz ApagaNaveLoop

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; ============= MovimentaNave =============
;	Faz todas as ações da nave, com base
;	no input do teclado. Movimenta para
;	esquerda (a), direita (d) e atira (esp)
;	
;	OBS: Movimentar para esquerda e direita
;	estão nessa subrotina. Atirar é uma sub
;	rotina separada.
; =========================================
MovimentaNave:
	push r0	; input do teclado -> posição da nave
	push r1	; comparações -> limites de movimentação

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
		pop r1
		pop r0
		rts

; ========== ConsomeCombustivel ===========
;	Consome o combustível da nave e chama
;	para redesenha-lo. Se o combustível ze
;	rar então chama GameOver.
; =========================================
ConsomeCombustivel:
	push r0	; combustivel da nave

	; decrementa combustivel
	load r0, combustivelNave
	dec r0
	store combustivelNave, r0

	jz GameOver
	call DesenhaCombustivel ; So desenha o combustivel quando muda!

	pop r0
	rts

; ========= AumentarCombustivel ===========
;	Aumenta o combustível da nave, chamada
;	quando o jogador encosta em um obj. 
;	combustível. Aumenta 5 pontos no
;	tanque. Caso ultrapasse 30 pontos não
;	altera.
; =========================================
AumentarCombustivel:
    push r0	; combustivel da nave
	push r1	; incremento -> comparativo

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

	pop r1
	pop r0
	rts

; ========== DesenhaCombustivel ===========
;	Desenha a barra de combustível na tela
;	essa função também apaga a barra pré-
; 	existente.
;
;	Chama ImprimeStr, que usa:
;		r0: pos inicial
;		r1: endereço da string
;		r2: cor de impressão
; =========================================
DesenhaCombustivel:
	push r0	; posições de impressao
	push r1	; string -> quantidade de combustivel
	push r2 ; caracter de bloco preenchido
	push r3 ; caracter de espaço
	push r4 ; limite da tela

	loadn r0, #1160
	loadn r1, #combustivelTexto
	loadn r2, #0
	call ImprimeStr

	loadn r0, #1166 			; Pos primeiro bloco de combustivel
	load r1, combustivelNave
	loadn r2, #125 				; bloco preenchido
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

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; == GeraObjetoCombustivelAleatoriamente ==
;	Gera o objeto combustível, utilizando
;	a subrotina PegaNumeroAleatorio.
;	O objeto gerado fica na primeira posi-
;	ção livre do vetor, se não houver não
;	gera.
; =========================================
GeraObjetoCombustivelAleatoriamente:
	push r0 ; ponteiro vetor das posições combustivel
	push r1	; limite do vetor
	push r2 ; Flag de morto
	push r3 ; valores do r0

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
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; ===== DesenhaTodosObjetoCombustivel =====
;	Desenha cada um dos objetos do vetor
;	posCombustiveis. Se o objeto tiver com
;	a FlagMorto ele não é desenhado
; =========================================
DesenhaTodosObjetoCombustivel:
	push r0 ; ponteiro do vetor de combustiveis
	push r1	; limite do vetor
	push r2 ; caracter para imprimir
	push r3 ; valor do r0
	push r4 ; flag morto para comparar

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	load r2, CombustivelObjetoCaracter
	load r4, FlagMorto

	DesenhaObjetoCombustivel_Loop:
		loadi r3, r0

		; Checa se o combustivel está morto
		; se estiver morto não tem que desenahr
		cmp r3, r4
		jeq DesenhaObjetoCombustivel_Loop_Fim

		outchar r2, r3

		DesenhaObjetoCombustivel_Loop_Fim:
			inc r0
			dec r1
			jnz DesenhaObjetoCombustivel_Loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ====== ApagaTodosObjetoCombustivel ======
;	Apaga todos objeto combustível da tela
;	colocando um espaço em branco no lugar
;	USO: Antes de movê-lo senão apaga o
;	lugar errado e antes de mata-lo.
; =========================================
ApagaTodosObjetoCombustivel:
	push r0 ; vetor de combustiveis
	push r1	; limite do vetor
	push r2 ; espaço em branco
	push r3 ; valor do vetor
	push r4 ; flag morto

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	loadn r2, #' '
	load r4, FlagMorto

	ApagaTodosObjetoCombustivel_Loop:
		loadi r3, r0

		; checa se ja morreu
		cmp r3, r4
		jeq ApagaTodosObjetoCombustivel_Loop_Fim

		outchar r2, r3					; Apaga o combustivel

		ApagaTodosObjetoCombustivel_Loop_Fim:
			inc r0
			dec r1
			jnz ApagaTodosObjetoCombustivel_Loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ==== MovimentaTodosObjetoCombustivel ====
;	Movimenta todos os objeto combustivel
;	verticalmente para baixo. Apaga todos
;	objeto combustível antes de mover, cha
;	mando a respectiva subrotina.
; =========================================
MovimentaTodosObjetoCombustivel:
	push r0 ; vetor de combustiveis
	push r1 ; limite do vetor
	push r2 ; Flag morto
	push r3 ; valor do vetor
	push r4 ; deslocamento para descer uma linha
	push r5 ; limite vertical

	call ApagaTodosObjetoCombustivel

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	load r2, FlagMorto
	loadn r4, #40
	loadn r5, #1120

	MovimentaTodosObjetoCombustivel_Loop:
		loadi r3, r0

		; checa se morreu
		cmp r3, r2
		jeq MovimentaTodosObjetoCombustivel_Loop_Fim

		add r3, r3, r4

		cmp r3, r5
		jle MovimentaTodosObjetoCombustivel_Loop_Salva

		load r3, FlagMorto

		MovimentaTodosObjetoCombustivel_Loop_Salva:
			storei r0, r3
		MovimentaTodosObjetoCombustivel_Loop_Fim:
			inc r0
			dec r1
			jnz MovimentaTodosObjetoCombustivel_Loop

	call ChecaColisaoTodosObjetoCombustivel

	MovimentaTodosObjetoCombustivel_Fim:
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; == ChecaColisaoTodosObjetoCombustivel ===
;	Checa a colisão de todos objeto comb
;	ustivel com a nave. Se houver colisão,
;	chama a subrotina AumentarCombustivel,
;	e também mata o combustível.
; =========================================
ChecaColisaoTodosObjetoCombustivel:
	push r0 ; vetor de combustiveis
	push r1 ; limite do vetor combustiveis
	push r2 ; valor do r0
	push r3 ; flag de morto -> posicao da nave
	push r4 ; vetor de corpo da nave
	push r5 ; limite do vetor corpo da nave
	push r6 ; valor do vetor corpo nave + posicao da nave

	loadn r0, #posCombustiveis
	load r1, QuantidadeCombustiveis
	ChecaColisaoTodosObjetoCombustivel_Loop:
	    loadi r2, r0

		load r3, FlagMorto			; checa se o combustivel está morto
		cmp r2, r3
		jeq ChecaColisaoTodosObjetoCombustivel_Loop_Fim

		; carrego as variaveis da nave
		; NOTA: poderia mover o load do r3 para fora dos loops
		; porém eu prefiro aqui para ficar mais organizado, mesmo
		; que aumente bastante o número de instruções.

        load r3, posNave
	    loadn r4, #CorpoNave
	    load r5, TamanhoCorpoNave
		ChecaColisaoTodosObjetoCombustivel_Loop_2:
		    loadi r6, r4	; carrega o valor do offset no r6
			add r6, r6, r3 	; soma a posição absoluta ao offset
			cmp r2, r6		; compara com a posicao do combustivel

			; if(r2 != r6) continue
			jne ChecaColisaoTodosObjetoCombustivel_Loop_2_Fim

            call AumentarCombustivel
            call MataObjetoCombustivel
            
            ; Se colidiu em um lugar já parte para o próximo objeto
            jmp ChecaColisaoTodosObjetoCombustivel_Loop_Fim 

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


; ================= Atirar ================
;	Cria um novo tiro na primeira posição
;	livre do vetor de tiros, se houver.
;	O tiro criado surge em cima da cabeça
;	da nave.
; =========================================
Atirar:
	push r0	; pos do novo tiro (posNave - 40)
	push r1 ; auxiliar
	push r2 ; Flag morto
	push r3 ; limite do vetor de tiros
	push r4 ; vetor de posição tiros
	push r5 ; valor do vetor

	load r0, posNave		; o tiro nasce uma linha acima da nave
	loadn r1, #40
	sub r0, r0, r1

	load r2, FlagMorto
	load r3, QuantidadeTiros
	loadn r4, #posTiros

	Atirar_ProcuraPosicaoLivre:
		loadi r5, r4		
		cmp r5, r2 			; checa se está morto
		jeq Atirar_Salvar	; se esta morto cria o tiro

		inc r4
		dec r3
		jnz Atirar_ProcuraPosicaoLivre

    jmp Atirar_Fim          ; chegou aqui porque não tem espaço livre

	Atirar_Salvar:			; quando chegar aqui o r4 tem o endereço do tiro livre
		storei r4, r0

    Atirar_Fim:
    	pop r5
    	pop r4
    	pop r3
    	pop r2
    	pop r1
    	pop r0
    	rts

; ========== DesenhaTodosTiros ============
;	Desenha todos os objetos de tiros,
;	se o objeto guarda a FlagMorto, então
;	não faz nada.
; =========================================
DesenhaTodosTiros:
	push r0	; vetor de tiros
	push r1	; caracter do tiro
	push r2 ; limite do vetor
	push r3 ; valor do vetor
	push r4 ; FlagMorto
	push r7 ; cor do tiro

	loadn r0, #posTiros
	load r1, CorpoTiroCaracter
	load r2, QuantidadeTiros
	load r4, FlagMorto

	; coloca a cor do score no tiro
	call PegaCorScore
	add r1, r1, r7

	DesenhaTodosTiros_Loop:
		loadi r3, r0
		cmp r3, r4
		jeq DesenhaTodosTiros_Loop_Fim

		outchar r1, r3

		DesenhaTodosTiros_Loop_Fim:
			inc r0
			dec r2
			jnz DesenhaTodosTiros_Loop

	DesenhaTodosTiros_Fim:
		pop r7
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; =========== ApagaTodosTiros =============
;	Apaga todos os tiros da tela, deve ser
;	usado antes de movimentar e antes de
;	matar o tiro.
; =========================================
ApagaTodosTiros:
	push r0 ; vetor de tiros
	push r1 ; espaço em branco
	push r2 ; limite do vetor
	push r3 ; valor do vetor
	push r4 ; FlagMorto

	loadn r0, #posTiros

	loadn r1, #' '
	load r2, QuantidadeTiros
	load r4, FlagMorto

	ApagaTodosTiros_Loop:
		loadi r3, r0
		cmp r3, r4
		jeq ApagaTodosTiros_Loop_Fim

		outchar r1, r3

		ApagaTodosTiros_Loop_Fim:
			inc r0
			dec r2
			jnz ApagaTodosTiros_Loop

	ApagaTodosTiros_Fim:
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; ========= MovimentaTodosTiros ===========
;	Movimenta todos os tiros na tela para
;	cima. Antes de movimentar chama a sub-
;	rotina de apagar os tiros.
; =========================================
MovimentaTodosTiros:
	push r0 ; vetor de tiros
	push r1 ; flag de morto
	push r2 ; limite do vetor
	push r3 ; valor do r0
	push r4 ; temporario (tamanho da linha -> limite vertical)

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
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; ======== ChecaColisaoTodosTiros =========
;	Verifica colisão de todos os tiros com
;	os helicopteros, com os barcos e com os
;	objeto combustivel, chamando as respec-
;	tivas subrotinas.
;
;	Cada subrotina devolve no r7 se houve
;	ou não colisão. Então, nessa subrotina
;	matamos o tiro que acertou. 
;	
;	OBS: Um tiro não mata dois objetos.
; =========================================
ChecaColisaoTodosTiros:
    push r0 ; vetor de tiros
	push r1 ; limite do vetor
	push r2 ; valor do r0
	push r3 ; flag morto
	push r7 ; retorno das subrotinas

	loadn r0, #posTiros
	load r1, QuantidadeTiros

	ChecaColisaoTodosTiros_Loop:
        loadi r2, r0
        load r3, FlagMorto
		cmp r2, r3
		jeq ChecaColisaoTodosTiros_Loop_Fim

		; CHECA COLISAO DO TIRO COM HELICOPTERO
		push r0 ; parametro da subrotina: posicao do tiro
			mov r0, r2
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

    pop r7
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ====== ChecaColisaoTiroHelicopteros ======
;	Verifica a colisão de um tiro dado com
;	todos os helicopteros.
;
;	PARÂMETRO: r0 -> posição de um tiro
;	RETORNO: r7 -> true/false
;
;	OBS: Essa função pode ser utilizada
;	para verificar se há um helicoptero
;	em uma posição específica. Não é
;	restrita só a tiros.
; =========================================
ChecaColisaoTiroHelicopteros:
    push r0	; parametro de posicao a verificar
	push r1 ; vetor helicopteros
	push r2 ; limite do vetor
	push r3 ; valor do r1
	push r4 ; flag morto -> vetor corpo helicoptero
	push r5 ; limite do vetor corpo helicoptero
	push r6 ; valor do r4
	; r7 -> retorno

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
		push r0	; parametro de endereço do helicoptero morto
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

; ====== ChecaColisaoTiroCombutiveis =======
;	Verifica a colisão de um tiro dado com
;	todos os combustiveis. Se houver, então
;	chama a subrotina de Explosão, para 
; 	matar em um raio.
;
;	PARÂMETRO: r0 -> posição de um tiro
;	RETORNO: r7 -> true/false
;
;	OBS: Essa função pode ser utilizada
;	para verificar se há um combustivel
;	em uma posição específica. Não é
;	restrita só a tiros.
; =========================================
ChecaColisaoTiroCombutiveis:
    push r0 ; parametro de posicao
	push r1 ; vetor de combustiveis
	push r2 ; limite do vetor
	push r3 ; valor do r1
	push r4 ; Flag de morto
	; r7 : retorno

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
        	; r0 é o outro parametro que é a posicao inicial
        	; já está!
	        loadn r1, #5 		; raio da explosao
	        call ExplosaoMataObjetos
        pop r1

        push r0 ; endereço do objeto combustivel
	        mov r0, r1
	        call MataObjetoCombustivel
        pop r0

        loadn r7, #1

    	ChecaColisaoTiroCombutiveis_Loop_Fim:
    	    inc r1
    		dec r2
    		jnz ChecaColisaoTiroCombutiveis_Loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ========= MataObjetoCombustivel =========
;	Mata um objeto combustivel. Antes de 
;	matar ele apaga todos os objetos da
;	tela.
;
;	PARÂMETRO: r0 -> endereço do objeto
; =========================================
MataObjetoCombustivel:
	push r0 ; parametro endereço
	push r1 ; flag morto

	call ApagaTodosObjetoCombustivel

	load r1, FlagMorto
	storei r0, r1

	pop r1
	pop r0
	rts


; =========== ExplosaoMataObjetos =========
;	Mata todos os objetos no raio da
;	explosão. Para isso, usa a subrotina
;	auxiliar DentroDoRaio, que verifica
;	se uma posicao está dentro ou fora
;	de um circulo.
;
;	PARÂMETRO: r0 -> centro da explosao
;	PARÂMETRO: r1 -> raio da explosao
; =========================================
ExplosaoMataObjetos:
	push r0 ; parametro centro
	push r1 ; parametro raio
	push r2 ; vetores objetos
	push r3 ; limites do vetores
	push r4 ; valor dos vetores
	push r5 ; flag morto -> comparação
	push r7	; retorno da DentroDoRaio

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

	pop r7
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ============== DentroDoRaio =============
;	Verifica se uma posição está dentro
;	de um círculo dado. Por meio de um
;	pitágoras.
;
;	PARÂMETRO: r0 -> centro do circulo
;	PARÂMETRO: r1 -> raio do circulo
;	PARÂMETRO: r7 -> posição
;	RETORNO: r7 -> true/false
; =========================================
DentroDoRaio:
	push r0
	push r1
	push r2 ; x da primeira posicao
	push r3 ; y da primeira posicao
	push r4 ; x da segunda posicao
	push r5 ; y da segunda posicao
	push r6 ; tamanho da linha -> |x1 - x2|
	; r7: parâmetro -> |y1 - y2| -> retorno

	loadn r6, #40
	div r3, r0, r6	
	mod r2, r0, r6	

	div r5, r7, r6	
	mod r4, r7, r6

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

; ===== GeraHelicopteroAleatoriamente =====
;	Gera um helicoptero na primeira posição
;	livre do vetor de helicopteros. Se não
;	houver, então não gera nada.
; =========================================
GeraHelicopteroAleatoriamente:
	push r0 ; vetor de helicopteros
	push r1	; limite do vetor
	push r2 ; flag de morto
	push r3 ; valor do vetor
	push r7 ; numero aleatorio

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
		pop r7
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; ======== DesenhaTodosHelicopteros =======
;	Desenha todos os helicopteros na tela,
;	se o helicoptero tiver a FlagMorto, não
;	desenha nada.
; =========================================
DesenhaTodosHelicopteros:
	push r0 ; vetor de helicopteros
	push r1 ; limite do vetor
	push r2 ; valor do vetor
	push r3 ; flagmorto -> vetor corpo helicoptero
	push r4 ; vetor caracteres
	push r5 ; limite dos vetores de corpo
	push r6 ; posicao relativa de uma parte do helicopter
	push r7 ; caracter de uma parte do helicoptero

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

    pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; ============ MataHelicoptero ============
;	Mata um helicoptero e soma os pontos
;	dados por matar um helicoptero chamando
;	a subrotina AumentaScore. Antes de
;	matar, ele apaga todos os helicopteros.
;
;	PARÂMETRO: r0 -> endereço do heli.
; =========================================
MataHelicoptero:
    push r0 ; parâmetro endereço do helicoptero a ser morto -> ScoreHelicoptero parametro de AumentaScore
	push r1 ; FlagMorto

    ; apago todos os helicopteros da tela antes de perder a posicao dele
    ; os demais serao redesenhados naturalmente
	call ApagaTodosHelicopteros

	load r1, FlagMorto
	storei r0, r1

	load r0, ScoreHelicoptero 		; pontuacao por matar helicoptero
	call AumentaScore

	pop r1
	pop r0
    rts

; ======= MovimentaTodosHelicopteros ======
;	Movimenta todos os helicotperos para
;	baixo. Antes de mover, apaga todos os
;	helicopteros.
; =========================================
MovimentaTodosHelicopteros:
	push r0 ; vetor de helicopteros
	push r1 ; limite do vetor
	push r2 ; valor do vetor
	push r3 ; temporário (FlagMorto -> tamanho linha)
	push r4 ; limite vertical

	call ApagaTodosHelicopteros			; helicoptero vai mover, então apago ele

	loadn r0, #posHelicopteros
	load r1, QuantidadeHelicopteros

	MovimentaTodosHelicopteros_Loop:
		loadi r2, r0
        load r3, FlagMorto
		cmp r2, r3
		jeq MovimentaTodosHelicopteros_Loop_Fim

        loadn r3, #40
        add r2, r2, r3  ; desce uma linha

        ; lembrar que o corpo do helicopter ocupa 4 quadrados
        ; então considerando a linha de combustivel não pode
        ; passar da linha 27, ou seja, posicao 1080
        loadn r4, #1080 ; limite vertical

		cmp r2, r4		; if(helicoptero passou limites) matar()
		jgr MovimentaTodosHelicopteros_Loop_Matar

		MovimentaTodosHelicopteros_Loop_Salvar:
			storei r0, r2
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
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

; ===== ChecaColisaoTodosHelicopteros =====
;	Checa colisão da nave com cada um dos
;	helicopteros em todo o corpo. Se houver
;	colisão chama GameOver.
;
;	NOTA: O uso de registradores aqui está
;	porco, pois não consegui evitar o spill
; =========================================
ChecaColisaoTodosHelicopteros:
	push r0 ; vetor de helicopteros <-> posição da nave
	push r1 ; limite do vetor <-> posicao da nave + offset
	push r2 ; posição de um helicoptero
	push r3 ; FlagMorto -> vetor corpo helicoptero
	push r4 ; limite do vetor corpo helicoptero
	push r5 ; posição + offset
	push r6 ; vetor corpo nave
	push r7 ; limite do vetor corpo nave

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

    pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ========= ApagaTodosHelicopteros ========
;	Apaga todos os helicopteros da tela.
; =========================================
ApagaTodosHelicopteros:
    push r0 ; vetor helicopteros
	push r1 ; limite do vetor helicopteros 
	push r2 ; valor da posição de um helicoptero
	push r3 ; vetor corpo helicoptero
	push r4 ; espaço branco
	push r5 ; limite do vetor corpo helicoptero
	push r6 ; posição + offset

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

; ========= GeraBarcoAleatoriamente =======
;	Gera um barco na primeira posição livre
;	não é aleatorio, pois segue a seguinte
;	regra:
;		- barcos em endereços pares nascem
;			na esquerda
;		- barcom em endereços impares
;			na direita.
;	Essa regra deixa o fluxo de movimento
;	horizontal bem melhor de trabalhar.
; =========================================
GeraBarcoAleatoriamente:
	push r0 ; limite do vetor
	push r1 ; vetor de barcos
	push r2 ; FlagMorto
	push r3 ; valor de um barco

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
		pop r3
		pop r2
		pop r1
		pop r0
	    rts

; ========= GeraBarcoAleatoriamente =======
;	Desenha todos os barcos na tela, de um
;	modo levemente porco.
; =========================================
DesenhaTodosBarcos:
	push r0 ; limite do vetor barcos
	push r1 ; vetor barcos
	push r2 ; valor da posição do barco
	push r3 ; FlagMorto -> caracteres do barco
	push r4 ; caracter a imprimir

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

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; ========= GeraBarcoAleatoriamente =======
;	Apaga todos os barcos da tela.
; =========================================
ApagaTodosBarcos:
	push r0 ; limite do vetor barcos
	push r1 ; vetor barcos
	push r2 ; posicao de um barco do vetor
	push r3 ; flagmorto -> espaço branco

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

	pop r3
	pop r2
	pop r1
	pop r0
    rts

; ====== MovimentaTodosBarcosVertical =====
;	Movimenta todos os barcos uma linha
;	para baixo. Antes de mover apaga todos.
; =========================================
MovimentaTodosBarcosVertical:
	push r0 ; limite do vetor barcos
	push r1 ; vetor barcos
	push r2 ; posição de um barco
	push r3 ; flagmorto	-> tamanho da linha -> y do barco
	push r4 ; limite vertical

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

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; ===== MovimentaTodosBarcosHorizontal ====
;	Movimenta todos os barcos um bloco para
;	o lado. Seguindo a mesma regra de gera
;	ção. Barcos pares andam para direita,
;	barcos impares, para a esquerda.
;
;	NOTA: só movimenta barcos em baixo da
;	linha quinze.
; =========================================
MovimentaTodosBarcosHorizontal:
	push r0 ; vetor posição dos barcos
	push r1 ; limite do vetor
	push r2 ; valor da posição do barco
	push r3 ; FlagMorto -> tamanho da linha -> linha do barco
	push r4 ; temporario

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

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
    rts

; =============== MataBarco ===============
;	Mata um barco e concede ao jogador os
;	pontos respectivos com a subrotina
;	AumentaScore.
;
;	PARÂMETRO: r0 -> endereço do barco.
; =========================================
MataBarco:
	push r0 ; parâmetro endereço do barco -> Score do barco
	push r1 ; FlagMorto

	; apagar todos os barcos antes de eu perder
	; a posição desse barco
	call ApagaTodosBarcos

	load r1, FlagMorto
	storei r0, r1

	load r0, ScoreBarco
	call AumentaScore

	pop r1
	pop r0
    rts

; ======== ChecaColisaoTodosBarcos ========
;	Checa a colisão de todos os barcos com
;	a nave. Se houver colisão, chama o
;	GameOver.
; =========================================
ChecaColisaoTodosBarcos:
	push r0 ; limite do vetor barcos
	push r1 ; vetor barcos
	push r2 ; valor do vetor
	push r3 ; FlagMorto -> vetor corpo nave
	push r4 ; limite do vetor corpo nave
	push r5 ; posição da nave
	push r6 ; posição da nave + offset

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

; ========= ChecaColisaoTiroBarcos ========
;	Checa a colisão de um tiro com todos os
;	barcos. Assim como as outras de checar
;	colisão com tiro, pode ser utilizada
;	para verificar se tem um barco na
;	posição. Se houver colisão, chama
;	MataBarco
;
;	PARÂMETRO: r0 -> posição a checar.
;	RETORNO: r7 -> true/false
; =========================================
ChecaColisaoTiroBarcos:
	push r0 ; parâmetro posição
	push r1 ; vetor posição barcos
	push r2 ; limite do vetor
	push r3 ; valor do vetor
	push r4 ; FlagMorto

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
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
	    rts

; ================= Delay =================
;	Faz um delay de alguns ciclos para
;	manter a jogabilidade.
;
;	OBS: Se o jogo estiver muito rápido
;	então, mudar os valores aqui. Isso
;	depende de computador para computador.
; =========================================
Delay:
    push r0 ; tamanho do loop longo
    push r1 ; tamanho do loop curto

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


; ============= DesenhaCenario ============
;	Desenha o cenário no jogo, com base em
;	uma regra fixa:
;		- grama da coluna 0-12 & 28-40
;		- da linha 0 até 28.
; =========================================
DesenhaCenario:
    push r0 ; caracter que representa a grama
	push r1 ; posição inicial
	push r2 ; linha limite
	push r3 ; quantidade de colunas
	push r4 ; linha atual
	push r5 ; tamanho da linha

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
; ============== ImprimeNumero ============
;	Imprime um número na tela.
;
;	PARÂMETRO: r0 -> posição inicial
;	PARÂMETRO: r1 -> número a ser impresso
;	PARÂMETRO: r2 -> cor para imprimir
;
;	RESULTADO: É o equivalente a um
;		printf("%05d") -> 00245
; =========================================
ImprimeNumero:
	push r0 ; posição inicial
	push r1 ; número a ser impresso
	push r2 ; cor 
	push r3 ; quantidade de digitos decimais do registrador
	push r4 ; 10^(5 - n)
	push r5 ; 10
	push r6 ; '0' para transformar em ASCII

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

; ====== FUNÇÕES RETIRADAS DE OUTROS JOGOS DO REPOSITÓRIO ======

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

ImprimeTelaInicio:
  push R0
  push R1
  push R2
  push R3

  loadn R0, #telainicio
  loadn R1, #0
  loadn R2, #1200

  ImprimeTelaInicio_Loop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne ImprimeTelaInicio_Loop

  pop R3
  pop R2
  pop R1
  pop R0
  rts


jmp main

telainicio : var #1200
  ;Linha 0
  static telainicio + #0, #3967
  static telainicio + #1, #3967
  static telainicio + #2, #3967
  static telainicio + #3, #3967
  static telainicio + #4, #3967
  static telainicio + #5, #3967
  static telainicio + #6, #3967
  static telainicio + #7, #3967
  static telainicio + #8, #3967
  static telainicio + #9, #3967
  static telainicio + #10, #3967
  static telainicio + #11, #3967
  static telainicio + #12, #3967
  static telainicio + #13, #3967
  static telainicio + #14, #3967
  static telainicio + #15, #3967
  static telainicio + #16, #3967
  static telainicio + #17, #3967
  static telainicio + #18, #3967
  static telainicio + #19, #3967
  static telainicio + #20, #3967
  static telainicio + #21, #3967
  static telainicio + #22, #3967
  static telainicio + #23, #3967
  static telainicio + #24, #3967
  static telainicio + #25, #3967
  static telainicio + #26, #3967
  static telainicio + #27, #3967
  static telainicio + #28, #3967
  static telainicio + #29, #3967
  static telainicio + #30, #3967
  static telainicio + #31, #3967
  static telainicio + #32, #3967
  static telainicio + #33, #3967
  static telainicio + #34, #3967
  static telainicio + #35, #3967
  static telainicio + #36, #3967
  static telainicio + #37, #3967
  static telainicio + #38, #3967
  static telainicio + #39, #3967

  ;Linha 1
  static telainicio + #40, #3967
  static telainicio + #41, #3967
  static telainicio + #42, #3967
  static telainicio + #43, #3967
  static telainicio + #44, #3967
  static telainicio + #45, #3967
  static telainicio + #46, #3967
  static telainicio + #47, #3967
  static telainicio + #48, #3967
  static telainicio + #49, #3967
  static telainicio + #50, #3967
  static telainicio + #51, #3967
  static telainicio + #52, #3967
  static telainicio + #53, #3967
  static telainicio + #54, #3967
  static telainicio + #55, #3967
  static telainicio + #56, #3967
  static telainicio + #57, #3967
  static telainicio + #58, #3967
  static telainicio + #59, #3967
  static telainicio + #60, #3967
  static telainicio + #61, #3967
  static telainicio + #62, #3967
  static telainicio + #63, #3967
  static telainicio + #64, #3967
  static telainicio + #65, #3967
  static telainicio + #66, #3967
  static telainicio + #67, #3967
  static telainicio + #68, #3967
  static telainicio + #69, #3967
  static telainicio + #70, #3967
  static telainicio + #71, #3967
  static telainicio + #72, #3967
  static telainicio + #73, #3967
  static telainicio + #74, #3967
  static telainicio + #75, #3967
  static telainicio + #76, #3967
  static telainicio + #77, #3967
  static telainicio + #78, #3967
  static telainicio + #79, #3967

  ;Linha 2
  static telainicio + #80, #3967
  static telainicio + #81, #3967
  static telainicio + #82, #3967
  static telainicio + #83, #3967
  static telainicio + #84, #3967
  static telainicio + #85, #3967
  static telainicio + #86, #3967
  static telainicio + #87, #3967
  static telainicio + #88, #3967
  static telainicio + #89, #3967
  static telainicio + #90, #3967
  static telainicio + #91, #3967
  static telainicio + #92, #3967
  static telainicio + #93, #3967
  static telainicio + #94, #3967
  static telainicio + #95, #3967
  static telainicio + #96, #3967
  static telainicio + #97, #3967
  static telainicio + #98, #3967
  static telainicio + #99, #3967
  static telainicio + #100, #3967
  static telainicio + #101, #3967
  static telainicio + #102, #3967
  static telainicio + #103, #3967
  static telainicio + #104, #3967
  static telainicio + #105, #3967
  static telainicio + #106, #3967
  static telainicio + #107, #3967
  static telainicio + #108, #3967
  static telainicio + #109, #3967
  static telainicio + #110, #3967
  static telainicio + #111, #3967
  static telainicio + #112, #3967
  static telainicio + #113, #3967
  static telainicio + #114, #3967
  static telainicio + #115, #3967
  static telainicio + #116, #3967
  static telainicio + #117, #3967
  static telainicio + #118, #3967
  static telainicio + #119, #3967

  ;Linha 3
  static telainicio + #120, #3967
  static telainicio + #121, #3967
  static telainicio + #122, #3967
  static telainicio + #123, #3967
  static telainicio + #124, #3967
  static telainicio + #125, #3967
  static telainicio + #126, #3967
  static telainicio + #127, #3967
  static telainicio + #128, #3967
  static telainicio + #129, #3967
  static telainicio + #130, #3967
  static telainicio + #131, #3967
  static telainicio + #132, #3967
  static telainicio + #133, #3967
  static telainicio + #134, #3967
  static telainicio + #135, #3967
  static telainicio + #136, #3967
  static telainicio + #137, #3967
  static telainicio + #138, #3967
  static telainicio + #139, #3967
  static telainicio + #140, #3967
  static telainicio + #141, #3967
  static telainicio + #142, #3967
  static telainicio + #143, #3967
  static telainicio + #144, #3967
  static telainicio + #145, #3967
  static telainicio + #146, #3967
  static telainicio + #147, #3967
  static telainicio + #148, #3967
  static telainicio + #149, #3967
  static telainicio + #150, #3967
  static telainicio + #151, #3967
  static telainicio + #152, #3967
  static telainicio + #153, #3967
  static telainicio + #154, #3967
  static telainicio + #155, #3967
  static telainicio + #156, #3967
  static telainicio + #157, #3967
  static telainicio + #158, #3967
  static telainicio + #159, #3967

  ;Linha 4
  static telainicio + #160, #3967
  static telainicio + #161, #3967
  static telainicio + #162, #3967
  static telainicio + #163, #3967
  static telainicio + #164, #3967
  static telainicio + #165, #3967
  static telainicio + #166, #3967
  static telainicio + #167, #3967
  static telainicio + #168, #3967
  static telainicio + #169, #3967
  static telainicio + #170, #3967
  static telainicio + #171, #3967
  static telainicio + #172, #3967
  static telainicio + #173, #3967
  static telainicio + #174, #3967
  static telainicio + #175, #3967
  static telainicio + #176, #3967
  static telainicio + #177, #3967
  static telainicio + #178, #3967
  static telainicio + #179, #3967
  static telainicio + #180, #3967
  static telainicio + #181, #3967
  static telainicio + #182, #3967
  static telainicio + #183, #3967
  static telainicio + #184, #3967
  static telainicio + #185, #3967
  static telainicio + #186, #3967
  static telainicio + #187, #3967
  static telainicio + #188, #3967
  static telainicio + #189, #3967
  static telainicio + #190, #3967
  static telainicio + #191, #3967
  static telainicio + #192, #3967
  static telainicio + #193, #3967
  static telainicio + #194, #3967
  static telainicio + #195, #3967
  static telainicio + #196, #3967
  static telainicio + #197, #3967
  static telainicio + #198, #3967
  static telainicio + #199, #3967

  ;Linha 5
  static telainicio + #200, #3967
  static telainicio + #201, #3967
  static telainicio + #202, #3967
  static telainicio + #203, #3967
  static telainicio + #204, #3967
  static telainicio + #205, #3967
  static telainicio + #206, #3967
  static telainicio + #207, #3967
  static telainicio + #208, #3967
  static telainicio + #209, #3967
  static telainicio + #210, #3967
  static telainicio + #211, #3967
  static telainicio + #212, #3967
  static telainicio + #213, #3967
  static telainicio + #214, #3967
  static telainicio + #215, #3967
  static telainicio + #216, #3967
  static telainicio + #217, #3967
  static telainicio + #218, #3967
  static telainicio + #219, #3967
  static telainicio + #220, #3967
  static telainicio + #221, #3967
  static telainicio + #222, #3967
  static telainicio + #223, #3967
  static telainicio + #224, #3967
  static telainicio + #225, #3967
  static telainicio + #226, #3967
  static telainicio + #227, #3967
  static telainicio + #228, #3967
  static telainicio + #229, #3967
  static telainicio + #230, #3967
  static telainicio + #231, #3967
  static telainicio + #232, #3967
  static telainicio + #233, #3967
  static telainicio + #234, #3967
  static telainicio + #235, #3967
  static telainicio + #236, #3967
  static telainicio + #237, #3967
  static telainicio + #238, #3967
  static telainicio + #239, #3967

  ;Linha 6
  static telainicio + #240, #3967
  static telainicio + #241, #3967
  static telainicio + #242, #3967
  static telainicio + #243, #3967
  static telainicio + #244, #3967
  static telainicio + #245, #3967
  static telainicio + #246, #3967
  static telainicio + #247, #3967
  static telainicio + #248, #3967
  static telainicio + #249, #3967
  static telainicio + #250, #3967
  static telainicio + #251, #3967
  static telainicio + #252, #3967
  static telainicio + #253, #3967
  static telainicio + #254, #3967
  static telainicio + #255, #3967
  static telainicio + #256, #3967
  static telainicio + #257, #3967
  static telainicio + #258, #3967
  static telainicio + #259, #3967
  static telainicio + #260, #3967
  static telainicio + #261, #3967
  static telainicio + #262, #3967
  static telainicio + #263, #3967
  static telainicio + #264, #3967
  static telainicio + #265, #3967
  static telainicio + #266, #3967
  static telainicio + #267, #3967
  static telainicio + #268, #3967
  static telainicio + #269, #3967
  static telainicio + #270, #3967
  static telainicio + #271, #3967
  static telainicio + #272, #3967
  static telainicio + #273, #3967
  static telainicio + #274, #3967
  static telainicio + #275, #3967
  static telainicio + #276, #3967
  static telainicio + #277, #3967
  static telainicio + #278, #3967
  static telainicio + #279, #3967

  ;Linha 7
  static telainicio + #280, #3967
  static telainicio + #281, #3967
  static telainicio + #282, #3967
  static telainicio + #283, #3967
  static telainicio + #284, #3967
  static telainicio + #285, #3967
  static telainicio + #286, #3967
  static telainicio + #287, #3967
  static telainicio + #288, #3967
  static telainicio + #289, #3967
  static telainicio + #290, #3967
  static telainicio + #291, #3967
  static telainicio + #292, #3967
  static telainicio + #293, #3967
  static telainicio + #294, #3967
  static telainicio + #295, #3967
  static telainicio + #296, #3967
  static telainicio + #297, #3967
  static telainicio + #298, #3967
  static telainicio + #299, #3967
  static telainicio + #300, #3967
  static telainicio + #301, #3967
  static telainicio + #302, #3967
  static telainicio + #303, #3967
  static telainicio + #304, #3967
  static telainicio + #305, #3967
  static telainicio + #306, #114
  static telainicio + #307, #3967
  static telainicio + #308, #3967
  static telainicio + #309, #3967
  static telainicio + #310, #3967
  static telainicio + #311, #3967
  static telainicio + #312, #3967
  static telainicio + #313, #3967
  static telainicio + #314, #3967
  static telainicio + #315, #3967
  static telainicio + #316, #3967
  static telainicio + #317, #3967
  static telainicio + #318, #3967
  static telainicio + #319, #3967

  ;Linha 8
  static telainicio + #320, #3967
  static telainicio + #321, #3967
  static telainicio + #322, #3967
  static telainicio + #323, #3967
  static telainicio + #324, #3967
  static telainicio + #325, #3967
  static telainicio + #326, #3967
  static telainicio + #327, #3967
  static telainicio + #328, #3967
  static telainicio + #329, #3967
  static telainicio + #330, #3967
  static telainicio + #331, #3967
  static telainicio + #332, #2386
  static telainicio + #333, #2377
  static telainicio + #334, #2390
  static telainicio + #335, #2373
  static telainicio + #336, #2386
  static telainicio + #337, #3967
  static telainicio + #338, #3967
  static telainicio + #339, #3967
  static telainicio + #340, #2386
  static telainicio + #341, #2369
  static telainicio + #342, #2377
  static telainicio + #343, #2372
  static telainicio + #344, #3967
  static telainicio + #345, #116
  static telainicio + #346, #115
  static telainicio + #347, #109
  static telainicio + #348, #3967
  static telainicio + #349, #3967
  static telainicio + #350, #3967
  static telainicio + #351, #3967
  static telainicio + #352, #3967
  static telainicio + #353, #3967
  static telainicio + #354, #3967
  static telainicio + #355, #3967
  static telainicio + #356, #3967
  static telainicio + #357, #3967
  static telainicio + #358, #3967
  static telainicio + #359, #3967

  ;Linha 9
  static telainicio + #360, #3967
  static telainicio + #361, #3967
  static telainicio + #362, #3967
  static telainicio + #363, #3967
  static telainicio + #364, #3967
  static telainicio + #365, #3967
  static telainicio + #366, #3967
  static telainicio + #367, #3967
  static telainicio + #368, #3967
  static telainicio + #369, #3967
  static telainicio + #370, #3967
  static telainicio + #371, #3967
  static telainicio + #372, #3967
  static telainicio + #373, #3967
  static telainicio + #374, #3967
  static telainicio + #375, #3967
  static telainicio + #376, #3967
  static telainicio + #377, #3967
  static telainicio + #378, #3967
  static telainicio + #379, #3967
  static telainicio + #380, #3967
  static telainicio + #381, #3967
  static telainicio + #382, #3967
  static telainicio + #383, #3967
  static telainicio + #384, #3967
  static telainicio + #385, #3967
  static telainicio + #386, #117
  static telainicio + #387, #3967
  static telainicio + #388, #3967
  static telainicio + #389, #3967
  static telainicio + #390, #3967
  static telainicio + #391, #3967
  static telainicio + #392, #3967
  static telainicio + #393, #3967
  static telainicio + #394, #3967
  static telainicio + #395, #3967
  static telainicio + #396, #3967
  static telainicio + #397, #3967
  static telainicio + #398, #3967
  static telainicio + #399, #3967

  ;Linha 10
  static telainicio + #400, #3967
  static telainicio + #401, #3967
  static telainicio + #402, #3967
  static telainicio + #403, #3967
  static telainicio + #404, #3967
  static telainicio + #405, #3967
  static telainicio + #406, #3967
  static telainicio + #407, #3967
  static telainicio + #408, #3967
  static telainicio + #409, #3967
  static telainicio + #410, #3967
  static telainicio + #411, #3967
  static telainicio + #412, #3967
  static telainicio + #413, #3967
  static telainicio + #414, #3967
  static telainicio + #415, #3967
  static telainicio + #416, #3967
  static telainicio + #417, #3967
  static telainicio + #418, #3967
  static telainicio + #419, #3967
  static telainicio + #420, #3967
  static telainicio + #421, #3967
  static telainicio + #422, #3967
  static telainicio + #423, #3967
  static telainicio + #424, #3967
  static telainicio + #425, #3967
  static telainicio + #426, #3967
  static telainicio + #427, #3967
  static telainicio + #428, #3967
  static telainicio + #429, #3967
  static telainicio + #430, #3967
  static telainicio + #431, #3967
  static telainicio + #432, #3967
  static telainicio + #433, #3967
  static telainicio + #434, #3967
  static telainicio + #435, #3967
  static telainicio + #436, #3967
  static telainicio + #437, #3967
  static telainicio + #438, #3967
  static telainicio + #439, #3967

  ;Linha 11
  static telainicio + #440, #3967
  static telainicio + #441, #3967
  static telainicio + #442, #3967
  static telainicio + #443, #3967
  static telainicio + #444, #3967
  static telainicio + #445, #3967
  static telainicio + #446, #3967
  static telainicio + #447, #3967
  static telainicio + #448, #3967
  static telainicio + #449, #3967
  static telainicio + #450, #3967
  static telainicio + #451, #3967
  static telainicio + #452, #3967
  static telainicio + #453, #3967
  static telainicio + #454, #3967
  static telainicio + #455, #3967
  static telainicio + #456, #3967
  static telainicio + #457, #3967
  static telainicio + #458, #3967
  static telainicio + #459, #3967
  static telainicio + #460, #3967
  static telainicio + #461, #3967
  static telainicio + #462, #3967
  static telainicio + #463, #3967
  static telainicio + #464, #3967
  static telainicio + #465, #3967
  static telainicio + #466, #3967
  static telainicio + #467, #3967
  static telainicio + #468, #3967
  static telainicio + #469, #3967
  static telainicio + #470, #3967
  static telainicio + #471, #3967
  static telainicio + #472, #3967
  static telainicio + #473, #3967
  static telainicio + #474, #3967
  static telainicio + #475, #3967
  static telainicio + #476, #3967
  static telainicio + #477, #3967
  static telainicio + #478, #3967
  static telainicio + #479, #3967

  ;Linha 12
  static telainicio + #480, #3967
  static telainicio + #481, #3967
  static telainicio + #482, #3967
  static telainicio + #483, #3967
  static telainicio + #484, #3967
  static telainicio + #485, #3967
  static telainicio + #486, #3967
  static telainicio + #487, #3967
  static telainicio + #488, #3967
  static telainicio + #489, #3967
  static telainicio + #490, #3967
  static telainicio + #491, #1646
  static telainicio + #492, #1647
  static telainicio + #493, #3967
  static telainicio + #494, #3967
  static telainicio + #495, #3967
  static telainicio + #496, #3967
  static telainicio + #497, #3967
  static telainicio + #498, #3967
  static telainicio + #499, #3967
  static telainicio + #500, #3967
  static telainicio + #501, #3967
  static telainicio + #502, #3967
  static telainicio + #503, #3967
  static telainicio + #504, #3967
  static telainicio + #505, #3967
  static telainicio + #506, #3967
  static telainicio + #507, #3967
  static telainicio + #508, #3967
  static telainicio + #509, #3967
  static telainicio + #510, #3967
  static telainicio + #511, #3967
  static telainicio + #512, #3967
  static telainicio + #513, #3967
  static telainicio + #514, #3967
  static telainicio + #515, #3967
  static telainicio + #516, #3967
  static telainicio + #517, #3967
  static telainicio + #518, #3967
  static telainicio + #519, #3967

  ;Linha 13
  static telainicio + #520, #3967
  static telainicio + #521, #3967
  static telainicio + #522, #3967
  static telainicio + #523, #3967
  static telainicio + #524, #3967
  static telainicio + #525, #3967
  static telainicio + #526, #3967
  static telainicio + #527, #3967
  static telainicio + #528, #3967
  static telainicio + #529, #3967
  static telainicio + #530, #3967
  static telainicio + #531, #1636
  static telainicio + #532, #1644
  static telainicio + #533, #3967
  static telainicio + #534, #3967
  static telainicio + #535, #3967
  static telainicio + #536, #3967
  static telainicio + #537, #3967
  static telainicio + #538, #3967
  static telainicio + #539, #3967
  static telainicio + #540, #3967
  static telainicio + #541, #3967
  static telainicio + #542, #2922
  static telainicio + #543, #2923
  static telainicio + #544, #3967
  static telainicio + #545, #3967
  static telainicio + #546, #3967
  static telainicio + #547, #3967
  static telainicio + #548, #3967
  static telainicio + #549, #3967
  static telainicio + #550, #3967
  static telainicio + #551, #3967
  static telainicio + #552, #3967
  static telainicio + #553, #3967
  static telainicio + #554, #3967
  static telainicio + #555, #3967
  static telainicio + #556, #3967
  static telainicio + #557, #3967
  static telainicio + #558, #3967
  static telainicio + #559, #3967

  ;Linha 14
  static telainicio + #560, #3967
  static telainicio + #561, #3967
  static telainicio + #562, #3967
  static telainicio + #563, #3967
  static telainicio + #564, #3967
  static telainicio + #565, #3967
  static telainicio + #566, #3967
  static telainicio + #567, #3967
  static telainicio + #568, #3967
  static telainicio + #569, #3967
  static telainicio + #570, #3967
  static telainicio + #571, #3967
  static telainicio + #572, #3967
  static telainicio + #573, #3967
  static telainicio + #574, #3967
  static telainicio + #575, #3967
  static telainicio + #576, #3967
  static telainicio + #577, #3967
  static telainicio + #578, #3967
  static telainicio + #579, #3967
  static telainicio + #580, #3967
  static telainicio + #581, #3967
  static telainicio + #582, #3967
  static telainicio + #583, #3967
  static telainicio + #584, #3967
  static telainicio + #585, #3967
  static telainicio + #586, #3967
  static telainicio + #587, #3967
  static telainicio + #588, #3967
  static telainicio + #589, #3967
  static telainicio + #590, #3967
  static telainicio + #591, #3967
  static telainicio + #592, #3967
  static telainicio + #593, #3967
  static telainicio + #594, #3967
  static telainicio + #595, #3967
  static telainicio + #596, #3967
  static telainicio + #597, #3967
  static telainicio + #598, #3967
  static telainicio + #599, #3967

  ;Linha 15
  static telainicio + #600, #3967
  static telainicio + #601, #3967
  static telainicio + #602, #3967
  static telainicio + #603, #3967
  static telainicio + #604, #3967
  static telainicio + #605, #3967
  static telainicio + #606, #3967
  static telainicio + #607, #3967
  static telainicio + #608, #3967
  static telainicio + #609, #3967
  static telainicio + #610, #3967
  static telainicio + #611, #3967
  static telainicio + #612, #3967
  static telainicio + #613, #3967
  static telainicio + #614, #3967
  static telainicio + #615, #3967
  static telainicio + #616, #3967
  static telainicio + #617, #3967
  static telainicio + #618, #3967
  static telainicio + #619, #3967
  static telainicio + #620, #3967
  static telainicio + #621, #3967
  static telainicio + #622, #3967
  static telainicio + #623, #3967
  static telainicio + #624, #3967
  static telainicio + #625, #3967
  static telainicio + #626, #3967
  static telainicio + #627, #3967
  static telainicio + #628, #3967
  static telainicio + #629, #3967
  static telainicio + #630, #3967
  static telainicio + #631, #3967
  static telainicio + #632, #3967
  static telainicio + #633, #3967
  static telainicio + #634, #3967
  static telainicio + #635, #3967
  static telainicio + #636, #3967
  static telainicio + #637, #3967
  static telainicio + #638, #3967
  static telainicio + #639, #3967

  ;Linha 16
  static telainicio + #640, #3967
  static telainicio + #641, #3967
  static telainicio + #642, #3967
  static telainicio + #643, #3967
  static telainicio + #644, #3967
  static telainicio + #645, #3967
  static telainicio + #646, #3967
  static telainicio + #647, #3967
  static telainicio + #648, #3967
  static telainicio + #649, #3967
  static telainicio + #650, #3967
  static telainicio + #651, #3967
  static telainicio + #652, #3967
  static telainicio + #653, #3967
  static telainicio + #654, #3967
  static telainicio + #655, #3967
  static telainicio + #656, #3967
  static telainicio + #657, #3967
  static telainicio + #658, #3967
  static telainicio + #659, #3967
  static telainicio + #660, #3967
  static telainicio + #661, #3967
  static telainicio + #662, #3967
  static telainicio + #663, #3967
  static telainicio + #664, #3967
  static telainicio + #665, #3967
  static telainicio + #666, #3967
  static telainicio + #667, #3967
  static telainicio + #668, #3967
  static telainicio + #669, #3967
  static telainicio + #670, #3967
  static telainicio + #671, #3967
  static telainicio + #672, #3967
  static telainicio + #673, #3967
  static telainicio + #674, #3967
  static telainicio + #675, #3967
  static telainicio + #676, #3967
  static telainicio + #677, #3967
  static telainicio + #678, #3967
  static telainicio + #679, #3967

  ;Linha 17
  static telainicio + #680, #3967
  static telainicio + #681, #3967
  static telainicio + #682, #3967
  static telainicio + #683, #3967
  static telainicio + #684, #3967
  static telainicio + #685, #3967
  static telainicio + #686, #3967
  static telainicio + #687, #3967
  static telainicio + #688, #3967
  static telainicio + #689, #3967
  static telainicio + #690, #3967
  static telainicio + #691, #3967
  static telainicio + #692, #3967
  static telainicio + #693, #3967
  static telainicio + #694, #3967
  static telainicio + #695, #3967
  static telainicio + #696, #3967
  static telainicio + #697, #3967
  static telainicio + #698, #3967
  static telainicio + #699, #3967
  static telainicio + #700, #3967
  static telainicio + #701, #3967
  static telainicio + #702, #3967
  static telainicio + #703, #3967
  static telainicio + #704, #3967
  static telainicio + #705, #3967
  static telainicio + #706, #3967
  static telainicio + #707, #3967
  static telainicio + #708, #3967
  static telainicio + #709, #3967
  static telainicio + #710, #3967
  static telainicio + #711, #3967
  static telainicio + #712, #3967
  static telainicio + #713, #3967
  static telainicio + #714, #3967
  static telainicio + #715, #3967
  static telainicio + #716, #3967
  static telainicio + #717, #3967
  static telainicio + #718, #3967
  static telainicio + #719, #3967

  ;Linha 18
  static telainicio + #720, #3967
  static telainicio + #721, #3967
  static telainicio + #722, #3967
  static telainicio + #723, #3967
  static telainicio + #724, #3967
  static telainicio + #725, #3967
  static telainicio + #726, #3967
  static telainicio + #727, #3967
  static telainicio + #728, #3967
  static telainicio + #729, #3967
  static telainicio + #730, #3967
  static telainicio + #731, #3967
  static telainicio + #732, #3967
  static telainicio + #733, #3967
  static telainicio + #734, #3967
  static telainicio + #735, #3967
  static telainicio + #736, #3967
  static telainicio + #737, #3967
  static telainicio + #738, #3967
  static telainicio + #739, #3967
  static telainicio + #740, #3967
  static telainicio + #741, #3967
  static telainicio + #742, #3967
  static telainicio + #743, #3967
  static telainicio + #744, #3967
  static telainicio + #745, #3967
  static telainicio + #746, #3967
  static telainicio + #747, #3967
  static telainicio + #748, #3967
  static telainicio + #749, #3967
  static telainicio + #750, #3967
  static telainicio + #751, #3967
  static telainicio + #752, #3967
  static telainicio + #753, #3967
  static telainicio + #754, #3967
  static telainicio + #755, #3967
  static telainicio + #756, #3967
  static telainicio + #757, #3967
  static telainicio + #758, #3967
  static telainicio + #759, #3967

  ;Linha 19
  static telainicio + #760, #3967
  static telainicio + #761, #3967
  static telainicio + #762, #3967
  static telainicio + #763, #3967
  static telainicio + #764, #3967
  static telainicio + #765, #3967
  static telainicio + #766, #3137
  static telainicio + #767, #3152
  static telainicio + #768, #3141
  static telainicio + #769, #3154
  static telainicio + #770, #3156
  static telainicio + #771, #3141
  static telainicio + #772, #3967
  static telainicio + #773, #2373
  static telainicio + #774, #2387
  static telainicio + #775, #2384
  static telainicio + #776, #2369
  static telainicio + #777, #2371
  static telainicio + #778, #2383
  static telainicio + #779, #3967
  static telainicio + #780, #3152
  static telainicio + #781, #3137
  static telainicio + #782, #3154
  static telainicio + #783, #3137
  static telainicio + #784, #3967
  static telainicio + #785, #3139
  static telainicio + #786, #3151
  static telainicio + #787, #3149
  static telainicio + #788, #3141
  static telainicio + #789, #3139
  static telainicio + #790, #3137
  static telainicio + #791, #3154
  static telainicio + #792, #3967
  static telainicio + #793, #3967
  static telainicio + #794, #3967
  static telainicio + #795, #3967
  static telainicio + #796, #3967
  static telainicio + #797, #3967
  static telainicio + #798, #3967
  static telainicio + #799, #3967

  ;Linha 20
  static telainicio + #800, #3967
  static telainicio + #801, #3967
  static telainicio + #802, #3967
  static telainicio + #803, #3967
  static telainicio + #804, #3967
  static telainicio + #805, #3967
  static telainicio + #806, #3967
  static telainicio + #807, #3967
  static telainicio + #808, #3967
  static telainicio + #809, #3967
  static telainicio + #810, #3967
  static telainicio + #811, #3967
  static telainicio + #812, #3967
  static telainicio + #813, #3967
  static telainicio + #814, #3967
  static telainicio + #815, #3967
  static telainicio + #816, #3967
  static telainicio + #817, #3967
  static telainicio + #818, #3967
  static telainicio + #819, #3967
  static telainicio + #820, #3967
  static telainicio + #821, #3967
  static telainicio + #822, #3967
  static telainicio + #823, #3967
  static telainicio + #824, #3967
  static telainicio + #825, #3967
  static telainicio + #826, #3967
  static telainicio + #827, #3967
  static telainicio + #828, #3967
  static telainicio + #829, #3967
  static telainicio + #830, #3967
  static telainicio + #831, #3967
  static telainicio + #832, #3967
  static telainicio + #833, #3967
  static telainicio + #834, #3967
  static telainicio + #835, #3967
  static telainicio + #836, #3967
  static telainicio + #837, #3967
  static telainicio + #838, #3967
  static telainicio + #839, #3967

  ;Linha 21
  static telainicio + #840, #3967
  static telainicio + #841, #3967
  static telainicio + #842, #3967
  static telainicio + #843, #3967
  static telainicio + #844, #3967
  static telainicio + #845, #3967
  static telainicio + #846, #3967
  static telainicio + #847, #3967
  static telainicio + #848, #3967
  static telainicio + #849, #3967
  static telainicio + #850, #3967
  static telainicio + #851, #3967
  static telainicio + #852, #3967
  static telainicio + #853, #3967
  static telainicio + #854, #3967
  static telainicio + #855, #3967
  static telainicio + #856, #3967
  static telainicio + #857, #3967
  static telainicio + #858, #3967
  static telainicio + #859, #3967
  static telainicio + #860, #3967
  static telainicio + #861, #3967
  static telainicio + #862, #3967
  static telainicio + #863, #3967
  static telainicio + #864, #3967
  static telainicio + #865, #3967
  static telainicio + #866, #3967
  static telainicio + #867, #3967
  static telainicio + #868, #3967
  static telainicio + #869, #3967
  static telainicio + #870, #3967
  static telainicio + #871, #3967
  static telainicio + #872, #3967
  static telainicio + #873, #3967
  static telainicio + #874, #3967
  static telainicio + #875, #3967
  static telainicio + #876, #3967
  static telainicio + #877, #3967
  static telainicio + #878, #3967
  static telainicio + #879, #3967

  ;Linha 22
  static telainicio + #880, #3967
  static telainicio + #881, #3967
  static telainicio + #882, #3967
  static telainicio + #883, #3967
  static telainicio + #884, #3967
  static telainicio + #885, #3967
  static telainicio + #886, #3967
  static telainicio + #887, #3967
  static telainicio + #888, #3967
  static telainicio + #889, #3967
  static telainicio + #890, #3967
  static telainicio + #891, #3967
  static telainicio + #892, #3967
  static telainicio + #893, #3967
  static telainicio + #894, #3967
  static telainicio + #895, #3967
  static telainicio + #896, #3967
  static telainicio + #897, #3967
  static telainicio + #898, #3967
  static telainicio + #899, #3967
  static telainicio + #900, #3967
  static telainicio + #901, #3967
  static telainicio + #902, #3967
  static telainicio + #903, #3967
  static telainicio + #904, #3967
  static telainicio + #905, #3967
  static telainicio + #906, #3967
  static telainicio + #907, #3967
  static telainicio + #908, #3967
  static telainicio + #909, #3967
  static telainicio + #910, #3967
  static telainicio + #911, #3967
  static telainicio + #912, #3967
  static telainicio + #913, #3967
  static telainicio + #914, #3967
  static telainicio + #915, #3967
  static telainicio + #916, #3967
  static telainicio + #917, #3967
  static telainicio + #918, #3967
  static telainicio + #919, #3967

  ;Linha 23
  static telainicio + #920, #3967
  static telainicio + #921, #3967
  static telainicio + #922, #3967
  static telainicio + #923, #3967
  static telainicio + #924, #3967
  static telainicio + #925, #3967
  static telainicio + #926, #3967
  static telainicio + #927, #3967
  static telainicio + #928, #3967
  static telainicio + #929, #3967
  static telainicio + #930, #3967
  static telainicio + #931, #3967
  static telainicio + #932, #3967
  static telainicio + #933, #3967
  static telainicio + #934, #3967
  static telainicio + #935, #3967
  static telainicio + #936, #3967
  static telainicio + #937, #3967
  static telainicio + #938, #3967
  static telainicio + #939, #3967
  static telainicio + #940, #3967
  static telainicio + #941, #3967
  static telainicio + #942, #3967
  static telainicio + #943, #3967
  static telainicio + #944, #3967
  static telainicio + #945, #3967
  static telainicio + #946, #3967
  static telainicio + #947, #3967
  static telainicio + #948, #3967
  static telainicio + #949, #3967
  static telainicio + #950, #3967
  static telainicio + #951, #3967
  static telainicio + #952, #3967
  static telainicio + #953, #3967
  static telainicio + #954, #3967
  static telainicio + #955, #3967
  static telainicio + #956, #3967
  static telainicio + #957, #3967
  static telainicio + #958, #3967
  static telainicio + #959, #3967

  ;Linha 24
  static telainicio + #960, #2599
  static telainicio + #961, #2599
  static telainicio + #962, #2599
  static telainicio + #963, #2599
  static telainicio + #964, #2599
  static telainicio + #965, #2599
  static telainicio + #966, #2599
  static telainicio + #967, #2599
  static telainicio + #968, #2599
  static telainicio + #969, #2599
  static telainicio + #970, #2599
  static telainicio + #971, #2599
  static telainicio + #972, #2599
  static telainicio + #973, #2599
  static telainicio + #974, #2599
  static telainicio + #975, #2599
  static telainicio + #976, #2599
  static telainicio + #977, #2599
  static telainicio + #978, #2599
  static telainicio + #979, #2599
  static telainicio + #980, #2599
  static telainicio + #981, #2599
  static telainicio + #982, #2599
  static telainicio + #983, #2599
  static telainicio + #984, #2599
  static telainicio + #985, #2599
  static telainicio + #986, #2599
  static telainicio + #987, #2599
  static telainicio + #988, #2599
  static telainicio + #989, #2599
  static telainicio + #990, #2599
  static telainicio + #991, #2599
  static telainicio + #992, #2599
  static telainicio + #993, #2599
  static telainicio + #994, #2599
  static telainicio + #995, #2599
  static telainicio + #996, #2599
  static telainicio + #997, #2599
  static telainicio + #998, #2599
  static telainicio + #999, #2599

  ;Linha 25
  static telainicio + #1000, #2599
  static telainicio + #1001, #2599
  static telainicio + #1002, #2599
  static telainicio + #1003, #2599
  static telainicio + #1004, #2599
  static telainicio + #1005, #2599
  static telainicio + #1006, #2599
  static telainicio + #1007, #2599
  static telainicio + #1008, #2599
  static telainicio + #1009, #2599
  static telainicio + #1010, #2599
  static telainicio + #1011, #2599
  static telainicio + #1012, #2599
  static telainicio + #1013, #2599
  static telainicio + #1014, #2599
  static telainicio + #1015, #2599
  static telainicio + #1016, #2599
  static telainicio + #1017, #2599
  static telainicio + #1018, #2599
  static telainicio + #1019, #2599
  static telainicio + #1020, #2599
  static telainicio + #1021, #2599
  static telainicio + #1022, #2599
  static telainicio + #1023, #2599
  static telainicio + #1024, #2599
  static telainicio + #1025, #2599
  static telainicio + #1026, #2599
  static telainicio + #1027, #2599
  static telainicio + #1028, #2599
  static telainicio + #1029, #2599
  static telainicio + #1030, #2599
  static telainicio + #1031, #2599
  static telainicio + #1032, #2599
  static telainicio + #1033, #2599
  static telainicio + #1034, #2599
  static telainicio + #1035, #2599
  static telainicio + #1036, #2599
  static telainicio + #1037, #2599
  static telainicio + #1038, #2599
  static telainicio + #1039, #2599

  ;Linha 26
  static telainicio + #1040, #2599
  static telainicio + #1041, #2599
  static telainicio + #1042, #2599
  static telainicio + #1043, #2599
  static telainicio + #1044, #2599
  static telainicio + #1045, #2599
  static telainicio + #1046, #2599
  static telainicio + #1047, #2599
  static telainicio + #1048, #2599
  static telainicio + #1049, #2599
  static telainicio + #1050, #2599
  static telainicio + #1051, #2599
  static telainicio + #1052, #2599
  static telainicio + #1053, #2599
  static telainicio + #1054, #2599
  static telainicio + #1055, #2599
  static telainicio + #1056, #2599
  static telainicio + #1057, #2599
  static telainicio + #1058, #2599
  static telainicio + #1059, #2599
  static telainicio + #1060, #2599
  static telainicio + #1061, #2599
  static telainicio + #1062, #2599
  static telainicio + #1063, #2599
  static telainicio + #1064, #2599
  static telainicio + #1065, #2599
  static telainicio + #1066, #2599
  static telainicio + #1067, #2599
  static telainicio + #1068, #2599
  static telainicio + #1069, #2599
  static telainicio + #1070, #2599
  static telainicio + #1071, #2599
  static telainicio + #1072, #2599
  static telainicio + #1073, #2599
  static telainicio + #1074, #2599
  static telainicio + #1075, #2599
  static telainicio + #1076, #2599
  static telainicio + #1077, #2599
  static telainicio + #1078, #2599
  static telainicio + #1079, #2599

  ;Linha 27
  static telainicio + #1080, #2599
  static telainicio + #1081, #2599
  static telainicio + #1082, #2599
  static telainicio + #1083, #2599
  static telainicio + #1084, #2599
  static telainicio + #1085, #2599
  static telainicio + #1086, #2599
  static telainicio + #1087, #2599
  static telainicio + #1088, #2599
  static telainicio + #1089, #2599
  static telainicio + #1090, #2599
  static telainicio + #1091, #2599
  static telainicio + #1092, #2599
  static telainicio + #1093, #2599
  static telainicio + #1094, #2599
  static telainicio + #1095, #2599
  static telainicio + #1096, #2599
  static telainicio + #1097, #2599
  static telainicio + #1098, #2599
  static telainicio + #1099, #2599
  static telainicio + #1100, #2599
  static telainicio + #1101, #2599
  static telainicio + #1102, #2599
  static telainicio + #1103, #2599
  static telainicio + #1104, #2599
  static telainicio + #1105, #2599
  static telainicio + #1106, #2599
  static telainicio + #1107, #2599
  static telainicio + #1108, #2599
  static telainicio + #1109, #2599
  static telainicio + #1110, #2599
  static telainicio + #1111, #2599
  static telainicio + #1112, #2599
  static telainicio + #1113, #2599
  static telainicio + #1114, #2599
  static telainicio + #1115, #2599
  static telainicio + #1116, #2599
  static telainicio + #1117, #2599
  static telainicio + #1118, #2599
  static telainicio + #1119, #2599

  ;Linha 28
  static telainicio + #1120, #2599
  static telainicio + #1121, #2599
  static telainicio + #1122, #2599
  static telainicio + #1123, #2599
  static telainicio + #1124, #2599
  static telainicio + #1125, #2599
  static telainicio + #1126, #2599
  static telainicio + #1127, #2599
  static telainicio + #1128, #2599
  static telainicio + #1129, #2599
  static telainicio + #1130, #2599
  static telainicio + #1131, #2599
  static telainicio + #1132, #2599
  static telainicio + #1133, #2599
  static telainicio + #1134, #2599
  static telainicio + #1135, #2599
  static telainicio + #1136, #2599
  static telainicio + #1137, #2599
  static telainicio + #1138, #2599
  static telainicio + #1139, #2599
  static telainicio + #1140, #2599
  static telainicio + #1141, #2599
  static telainicio + #1142, #2599
  static telainicio + #1143, #2599
  static telainicio + #1144, #2599
  static telainicio + #1145, #2599
  static telainicio + #1146, #2599
  static telainicio + #1147, #2599
  static telainicio + #1148, #2599
  static telainicio + #1149, #2599
  static telainicio + #1150, #2599
  static telainicio + #1151, #2599
  static telainicio + #1152, #2599
  static telainicio + #1153, #2599
  static telainicio + #1154, #2599
  static telainicio + #1155, #2599
  static telainicio + #1156, #2599
  static telainicio + #1157, #2599
  static telainicio + #1158, #2599
  static telainicio + #1159, #2599

  ;Linha 29
  static telainicio + #1160, #2599
  static telainicio + #1161, #2599
  static telainicio + #1162, #2599
  static telainicio + #1163, #2599
  static telainicio + #1164, #2599
  static telainicio + #1165, #2599
  static telainicio + #1166, #2599
  static telainicio + #1167, #2599
  static telainicio + #1168, #2599
  static telainicio + #1169, #2599
  static telainicio + #1170, #2599
  static telainicio + #1171, #2599
  static telainicio + #1172, #2599
  static telainicio + #1173, #2599
  static telainicio + #1174, #2599
  static telainicio + #1175, #2599
  static telainicio + #1176, #2599
  static telainicio + #1177, #2599
  static telainicio + #1178, #2599
  static telainicio + #1179, #2599
  static telainicio + #1180, #2599
  static telainicio + #1181, #2599
  static telainicio + #1182, #2599
  static telainicio + #1183, #2599
  static telainicio + #1184, #2599
  static telainicio + #1185, #2599
  static telainicio + #1186, #2599
  static telainicio + #1187, #2599
  static telainicio + #1188, #2599
  static telainicio + #1189, #2599
  static telainicio + #1190, #2599
  static telainicio + #1191, #2599
  static telainicio + #1192, #2599
  static telainicio + #1193, #2599
  static telainicio + #1194, #2599
  static telainicio + #1195, #2599
  static telainicio + #1196, #2599
  static telainicio + #1197, #2599
  static telainicio + #1198, #2599
  static telainicio + #1199, #2599


