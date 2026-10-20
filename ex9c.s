.data
CR: .word32 0x10000
DR: .word32 0x10008

String: .asciiz "7109"

.code

lwu r1,CR(r0)
lwu r2,DR(r0)

daddi r5,r0,0
daddi r6,r0,0
daddi r10, r0,10
while:

lb r4,String(r5)

beqz r4,fimwhile

dmul r6,r6,r10

daddi r4,r4,-48

daddi r6,r6,r4

daddi r5,r5,1

j while

fimwhile:

sd r6;(r2)

daddi r3,r0,1
sd r3,(r1º)