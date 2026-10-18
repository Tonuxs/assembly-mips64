.data
A:    .word 0
B:    .word 0
CR:   .word32 0x10000
DR:   .word32 0x10008
msg1: .asciiz "Iguais!"
msg2: .asciiz "O maior e: "

.text
    lwu r1, CR(r0)
    lwu r2, DR(r0)

    ; Ler o primeiro valor
    daddi r10, r0, 8
    sd r10, 0(r1)
    ld r4, 0(r2)
    sd r4, A(r0)

    ; Ler o segundo valor
    sd r10, 0(r1)
    ld r5, 0(r2)
    sd r5, B(r0)

    ; Se forem diferentes, procurar o maior
    bne r4, r5, Diferentes

    ; Se forem iguais, mostrar a mensagem
    daddi r6, r0, msg1
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)

    halt

Diferentes:
    ; Mostrar "O maior e: "
    daddi r6, r0, msg2
    sd r6, 0(r2)
    daddi r10, r0, 4
    sd r10, 0(r1)

    ; Assumir que o maior e A
    dadd r7, r4, r0

    ; r3 = 1 se A < B; caso contrario, r3 = 0
    slt r3, r4, r5

    ; Se A < B for falso, manter A como maior
    beqz r3, MostrarMaior

    ; Se A < B for verdadeiro, o maior e B
    dadd r7, r5, r0

MostrarMaior:
    ; Mostrar o maior como inteiro com sinal
    sd r7, 0(r2)
    daddi r10, r0, 2
    sd r10, 0(r1)

    halt