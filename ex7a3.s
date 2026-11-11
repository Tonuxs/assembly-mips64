.data


.code
  daddi r29,r0,0x80; inicialização do endereço da pilha

  ;ex 7a1 controlo das portas (7654321)
  ; 0 = aberto - 1 = Fecahdo
  ; 8 = portas (0-7)
  
  daddi r2,r0,8 ; numero d ebits necessarios
  daddi r1,r0,0xDE ; 1101 1110; tem a porta o e 5 abertas
  andi r1, r1,0xFB ; 1101 1010; tem a porta 0, 2 e 5 abertas
  ori r1, r1,0x20 ; 1111 1010; tem a porta 0 e 2 abertas
  
  jal Bin; chamada da rotina
  halt  

; Função Bin
; Mostra binário com n bits e muda linha
; Recebe valor em r1 e n em r2
; n deve estar ente 1 e 64
; Utiliza 72 Bytes na pilha

Bin:
  ;r8: aux
  ;r9: control; data: 8(r9)
  ;r10: valor
  ;r11: n
  
  ; preservar a0 e a1
  daddi r10,r1,0; valor
  daddi r11,r2,0; n
  
  ; control = 0x10000
  daddi r9,r0,0x1000
  dsll r9,r9,4

  daddi r30,r29,0; âncora

  ;reserva string de 64+8 Bytes na pilha
  daddi r29,r29,-72
  
  daddi r30,r30,-1
  sb r0,(r30) ; terminador NULL

  daddi r30,r30,-1
  daddi r8,r0,0xa
  sb r8,(r30) ; muda linha

WhileBin:  
  daddi r30,r30,-1; posição anterior

  ; se múltiplo de 8 insere espaço
  dsub r8,r2,r11;
  andi r8,r8,7;
  bnez r8,NaoMultiplo8
  daddi r8,r0,32; espaço
  sb r8,(r30); espaço
  daddi r30,r30,-1; posição anterior
NaoMultiplo8:    
  
  andi r8,r10,1; aplica máscara ...00001
  daddi r8,r8,48 ; obtém caracter '0'/'1'
  sb r8,(r30); '0' ou '1'
  
  dsrl r10,r10,1; retira lsb
  daddi r11,r11,-1; n--
  
  bnez r11,WhileBin ; n>0?
  
  ; Mostra string com o binário
  sd r30,8(r9); data
  daddi r8,r0,4
  sd r8,(r9); control

  ; Muda linha

  ; Liberta string da pilha
  daddi r29,r29,72
  
  
  jr r31