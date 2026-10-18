.data
CR: .word32 0x10000
DR: .word32 0x10008
MSG: .asciiz "hello world"

.text
    lwu r1, CR(r0)
    lwu r2, DR(r0)
	
	daddi r10,r0, MSG ; colcoa em r10 a mensagem 
	
	sd r10, 0(r2) ; envia a mensagem pro data register
	
	daddi r3, r0, 4 ; coloca em r3 o codigo de controlo para imprimir strings 
	
	sd r3, (r1) ; chamar o controlo, mostra a mensagme que esta em r2
	
	
	