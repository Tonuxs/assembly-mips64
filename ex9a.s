.data
CR: .word32 0x10000
DR: .word32 0x10008

String: .asciiz "SC EI IPLeiria"

.code
lwu r1,CD(r0)
lwu r2,DR(r0)

daddi r4, r0,0

while:

lb r3.String(r4)

beqz r3,fimwhile

daddi r4, r4,1

j while

fimwhile:

sd r4,(r2)

daddi r3,r0,1
sd r3,(r1)

halt