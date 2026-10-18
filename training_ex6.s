.data
CR: .word32 0x10000 
DR: .word32 0x10008

msgSecreto: .asciiz "introduza o numero secreto: "
msgTentar: .asciiz "inttroduza uma tentativa: "
msgMaior: .asciiz "O numero secreto é maior!\n"
msgMenor: .asciiz "O numero secreto e menor!\n"
msgFim: .asciiz "parabens! Acertou! \ntentativas: "

.text
	lwu r1, CR(r0)
	lwu r2, DR(r0)
	
	daddi r6,r0,msgSecreto
	sd r6, 0(r2)
	daddi r10, r0, 4
	sd r10, 0(r1)
	
	daddi r10, r0, 8
	sd r10, 0(r1)
	ld r4, 0(r2)
	
	daddi r10, r0, 6
	sd r10, 0(r1)
	
	daddi r7, r0, 0
	
tentar:
	daddi r6,r0,msgTentar
	sd r6, 0(r2)
	daddi r10, r0, 4
	sd r10, 0(r1)
	
	daddi r10, r0, 8
	sd r10, 0(r1)
	ld r5, 0(r2)
	
	daddi r7, r7,1
	
	beq r4,r5, Acertou
	slt r3, r5, r4
	beqz r3, secretoMenor
	
	daddi r6, r0,msgMaior
	sd r6, 0(r2)
	daddi r10, r0, 4
	sd r10, 0(r1)
	j tentar
	
secretoMenor:
	daddi r6, r0,msgMenor
	sd r6, 0(r2)
	daddi r10, r0,4
	sd r10, 0(r1)
	j tentar
Acertou:
	daddi r6, r0, msgFim
	sd r6, 0(r2)
	daddi r10, r0, 4
	sd r10, 0(r1)
	
	sd r7, 0(r2)
	daddi r10, r0, 2
	sd r10, 0(r1)
	
	halt