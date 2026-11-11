.data
2
3 CR: .word32 0x10000
4 DR: .word32 0x10008
5
6 String: .asciiz "SC EI IPLeiria"
7
8
9 .code
10
11 lwu r1,CR(r0)
12 lwu r2,DR(r0)
13
14 ; r3 = caracter atual
15 ; r4 = indice
16
17 ; i = 0
18 daddi r4,r0,0
19
20
21 While:
22
23 ; carregar String[i]
24 lb r3,String(r4)
25
26 ; fim da string?
27 beqz r3,FimWhile
28
29 ; i++
30 daddi r4,r4,1
31
32 j While
33
34
35 FimWhile:
36
37 ; r4 contem o numero de caracteres
38
39 ; mostrar contador
40 sd r4,(r2)
41
42 daddi r3,r0,1
   sd r3,(r1)
 halt