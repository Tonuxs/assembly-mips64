.data

CR: .word32 0x10000
DR: .word32 0x10008

.text

main:
	;enderecos do terminaL
	lwu $s1,CR($zero)
	lwu $s2,DR($zero)
	
	;posicionar a pilha
	daddi $sp,$zero,0x200
	
	;pedir a
	daddi $s3,$zero,8
	sd $s3,($s1)
	ld $s4,0($s2)
	
	;pedir b
	sd $s3, ($s1)
	ld $s5, 0($s2)
	
	;reservar espaço na pilha
	;2  inteiros x 8 bytes = 16
	daddi $sp,$sp,-16
	
	;colocar parametros na pilha 
	sd $s4,0($sp) 
	sd $s5,8($sp)
	
	jal Max
	
	; quando Max termina volta aqui
	
	;libertar os 16 bytes
	daddi $sp,$sp,16	
	;mostrar o maior
	
	sd $v0,($s2)
	
	daddi $s3,$zero,1
	sd $s3,($s1)
	
	halt
	
Max:
	;onter parametros da pilha
	ld $t1,0($sp)
	ld $t2,8($sp)
	
	;salt last then
	slt $t0,$t1,$t2
	
	;se $t0 !=0, entao a < b
	bnez $t0,bMaior
	
	;caso contrario a>= b
	dadd $v0,$t1,$zero
	
	J fimMax
	
bMaior:
	; b é maior
	dadd $v0,$t2,$zero
	
fimMax:
	;regressar ao programa principal
	jr $ra