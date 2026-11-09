main:
	loadn r0, #43
	loadn r1, #43
	loadn r2, #0

	call ImprimeNumero

	halt

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
		add r5, r5, r6

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

