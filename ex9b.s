.data
CR: .word32 0x10000
DR: .word32 0x10008

String: .asciiz "Sistemas Computacionais 64z!"

.code

	lwu r1,CR(r0)
	lwu r2,DR(r0)

	daddi r3,r0,0

while:

	lb r4,String((r5)

	beqz r4,fimwhile

	slti r3,r4,97

	beqz r3,naoconverte

	slti r3,r4,123	

	beqz r3,naoconverte

	daddi r4,r4,-32

	sb r4,String(r5)

naoconverte:

	daddi r5, r5,1

j while

fimwhile:

	daddi r3,r0,String
	sd r3,(r2)

	daddi r3,r0,4
	sd r3,(r1)

halt