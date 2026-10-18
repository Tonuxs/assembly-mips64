.data
CR: .word32 0x10000
DR: .word32 0x10008

msgSecreto: .asciiz "Introduza o numero secreto: "
msgTentar:  .asciiz "Introduza uma tentativa: "
msgMaior:   .asciiz "O numero secreto e maior!\n"
msgMenor:   .asciiz "O numero secreto e menor!\n"
msgFim:     .asciiz "Parabens! Acertou!\nTentativas: "

.text
    lwu r1, CR(r0)
    lwu r2, DR(r0)

    ; Pedir o numero secreto
    daddi r6, r0, msgSecreto
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)

    ; Ler o numero secreto para r4
    daddi r10, r0, 8
    sd r10, 0(r1)
    ld r4, 0(r2)

    ; Limpar o terminal
    daddi r10, r0, 6
    sd r10, 0(r1)

    ; Contador de tentativas = 0
    daddi r7, r0, 0

Tentar:
    ; Mostrar o pedido de tentativa
    daddi r6, r0, msgTentar
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)

    ; Ler a tentativa para r5
    daddi r10, r0, 8
    sd r10, 0(r1)
    ld r5, 0(r2)

    ; Contar esta tentativa
    daddi r7, r7, 1

    ; Se acertou, saltar para Acertou
    beq r4, r5, Acertou

    ; r3 = 1 se tentativa < secreto
    slt r3, r5, r4
    beqz r3, SecretoMenor

    ; O numero secreto e maior que a tentativa
    daddi r6, r0, msgMaior
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)
    j Tentar

SecretoMenor:
    ; O numero secreto e menor que a tentativa
    daddi r6, r0, msgMenor
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)
    j Tentar

Acertou:
    ; Mostrar os parabens
    daddi r6, r0, msgFim
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)

    ; Mostrar o numero de tentativas
    sd r7, 0(r2)
    daddi r10, r0, 2
    sd r10, 0(r1)

    halt