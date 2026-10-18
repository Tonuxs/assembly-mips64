.data
A:    .word 0
B:    .word 0
CR:   .word32 0x10000
DR:   .word32 0x10008
msg1: .asciiz "Iguais!"

.text
    lwu r1, CR(r0)
    lwu r2, DR(r0)

    daddi r10, r0, 8     ; comando para ler um valor

    sd r10, 0(r1)       ; pede o primeiro valor
    ld r4, 0(r2)        ; lê o valor de DATA
    sd r4, A(r0)        ; guarda em A

    sd r10, 0(r1)       ; pede o segundo valor
    ld r5, 0(r2)        ; lê o valor de DATA
    sd r5, B(r0)        ; guarda em B

    bne r4, r5, NaoFaz  ; se forem diferentes, termina

    daddi r10, r0, msg1 ; endereço da mensagem
    sd r10, 0(r2)       ; coloca o endereço em DATA
    daddi r10, r0, 4    ; comando para mostrar uma string
    sd r10, 0(r1)       ; mostra "Iguais!"

NaoFaz:
    halt