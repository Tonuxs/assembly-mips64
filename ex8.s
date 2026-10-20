  .data
  ;declaraçao do vetor de 64 bits
  Vetor: .word16 3, 15, 100, 7, 0xF9876543987625AA
		 .word16 17, 5, 15, -100, 2023
		 
Vlen: .word 10

CR: .word32 0x10000
DR: .word32 0x10008

.code 
; r5 = indice i 
; r3 = auxiliar
; r4 = elemento atual
; r8 = deslocaento = i*8
; r10 = nuemro de elementos
; r2 = endereço do data
; r1 = endereço do CONTROL

lwu r2, DR(r0)
lwu r1, CR(r0)

; carregar tamanho do vetor
ld r10, Vlen(r0)

; i = 0
daddi r5,r0,0

for:
	; verifica se i < Vlen
	slt r3,r5,r10
	
	;se nao, terminar ciclo
	beqz r3,fimfor
	
	;64 bits = 8 bytes
	;deslocamento = i*8
	
	daddi r3, r0,8
	dmul r8,r5,r3
	
	ld r4, Vetor(r8)
	
	sd r4,(r2)
	
	;codigo 2: inteiro com sinal
	daddi r3,r0,2
	sd r3,(r1)
	
	; i++
	daddi r5,r5,1
	
	j for
	
fimfor:
; quarto elemento -> indice 3
daddi r5,r0,3

; cada elemento ocupa 8 bytes
daddi r3,r0,2

; Carregar Vetor[3]
dmul r8,r5,r3

; soamr 1
lh r4,Vetor(r8)

daddi r4,r4,1

; guardra novamente no Vetor[3]
sh r4,Vetor(r8)

halt  