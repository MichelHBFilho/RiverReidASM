jmp main

; Posicoes do corpo com relacao a cabeca da nave
; Cabeca		[0] = 0
; Asa esquerda	[1] = 39
; Corpo			[2] = 40
; Asa direita 	[3] = 41
; Bunda 		[4] = 80

CorpoNave: var #5
static CorpoNave + #0, #0
static CorpoNave + #1, #39
static CorpoNave + #2, #40
static CorpoNave + #3, #41
static CorpoNave + #4, #80

CorpoNaveCaracteres: string "adhlz"

; Posicao da cabeca!!!
posNaveX: var #1
posNaveY: var #1

main:
    loadn r0, #20 ; Nasce no centro da tela
    loadn r1, #25 ; Y sempre fica em 27
    store posNaveX, r0
    store posNaveY, r1

	mainLoop:
		call DesenharNave
		call Delay
		call ApagaNave
		call Movimenta
		jmp mainLoop

    halt

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

Movimenta:
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

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
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
		storei r6, r4
   ImprimeStr_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6			; Incrementa o ponteiro da String da Tela 0
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

; Declara e preenche tela linha por linha (40 caracteres):
tela0Linha0  :  string "                                        "
tela0Linha1  :  string "                                        "
tela0Linha2  :  string "                                        "
tela0Linha3  :  string "                                        "
tela0Linha4  :  string "                                        "
tela0Linha5  :  string "                                        "
tela0Linha6  :  string "                                        "
tela0Linha7  :  string "                                        "
tela0Linha8  :  string "                                        "
tela0Linha9  :  string "                                        "
tela0Linha10  : string "                                        "
tela0Linha11  : string "                                        "
tela0Linha12  : string "                                        "
tela0Linha13  : string "                                        "
tela0Linha14  : string "                                        "
tela0Linha15  : string "                                        "
tela0Linha16  : string "                                        "
tela0Linha17  : string "                                        "
tela0Linha18  : string "                                        "
tela0Linha19  : string "                                        "
tela0Linha20  : string "                                        "
tela0Linha21  : string "                                        "
tela0Linha22  : string "                                        "
tela0Linha23  : string "                                        "
tela0Linha24  : string "                                        "
tela0Linha25  : string "                    A                   "
tela0Linha26  : string "                   dHl                  "
tela0Linha27  : string "                    v                   "
tela0Linha28  : string "                                        "
tela0Linha29  : string "                                        "
