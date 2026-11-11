.data

CR: .word32 0x10000
DR: .word32 0x10008

.text

main:
	
	jal rotina1
	
	; quando Max termina volta aqui
	ld $s3,0($sp)
	;libertar os 16 bytes
	daddi $sp,$sp,16	
	;mostrar o maior
	
	sd $s3,($s2)
	daddi $s3,$zero,1
	sd $s3,($s1)
	
	halt
	
	
rotina1:
	;enderecos do terminaL
	lwu $s1,CR($zero)
	lwu $s2,DR($zero)
	
	;posicionar a pilha
	daddi $sp,$zero,0x200
	
	daddi $sp,$sp,-8 
	sd $ra,($sp)

	;pedir a
	daddi $s3,$zero,8
	sd $s3,($s1)
	ld $s4,0($s2)
	
	;pedir b
	sd $s3, ($s1)
	ld $s5, 0($s2)
	
	; valor que deve sobreviver a chamada
	daddi $s0,$zero,0xDAD
	
	;reservar espaço na pilha pro control
	;2  inteiros x 8 bytes = 16
	daddi $sp,$sp,-16
	sd $t1,0($sp)
	sd $t2,8($sp)
	
	;reservar espaço na pilha pro control
	;2  inteiros x 8 bytes = 16
	daddi $sp,$sp,-16
	
	;colocar parametros na pilha 
	sd $t4,0($sp) 
	sd $t5,8($sp)
	
	jal Max
	
	;resultado devolvido por max
	ld $t6,0($sp)
	
	;libertar os parametros de max
	daddi $sp,$sp,16
	
	j fimmax
	
Max:
	daddi $fp,$sp,0
    ;reservar mais um espaço na pilha	
	daddi $sp,$sp,-8
	
	;reservar mais um espaço na pilha	
	daddi $sp,$sp,-8
	
	daddi $s0,$zero,0xBAD
	
	;stack pointer parametros da pilha
	ld $t1,0($fp)
	ld $t2,8($fp)
	
	; i = 6 
	daddi $t3,$zero,6 
	; i++
	sd $t3,-8($fp)
	
	daddi $t3,$t3,1
	sd $t3,-8($fp)
	
	;salt last then
	slt $t0,$t1,$t2
	
	;se $t0 !=0, entao a < b
	bnez $t0,$a1MaiorOuIgual
	
	sd $t1,0($fp)
	J fimMax
	
$a1MaiorOuIgual: 
    sd $t2,0($fp)
	
fimMax:
	;restaura o valor original de $s0
	ld $s0,0($sp)

	;liberta o espaco da pilha
	daddi $sp,$sp,8

	;regressar ao programa principal
	jr $ra