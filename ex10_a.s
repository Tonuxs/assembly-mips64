.data

CR: .word32 0x10000
DR: .word32 0x10008

.text

main:
	;enderecos do terminaL
	lwu $s1,CR($zero)
	lwu $s2,DR($zero)
	
	;pedir a
	daddi $s3,$zero,8
	sd $s3,($s1)
	ld $s0,0($s2)
	
	;pedir b
	sd $s3, ($s1)
	ld $a1, 0($s2)
	
	jal Max
	
	; quando Max termina volta aqui
	
	;mostrar o maior
	
	sd $v0,($s2)
	
	daddi $s3,$zero,1
	sd $s3,($s1)
	
	halt
	
Max:
	;salt last then
	slt $t0,$a0,$a1
	
	;se $t0 !=0, entao a < b
	bnez $t0,a1Maior
	
	;caso contrario a>= b
	dadd $v0,$a0,$zero
	
	J fimMax
	
a1Maior:
	; b é maior
	dadd $v0,$a1,$zero
	
fimMax:
	;regressar ao programa principal
	jr $ra