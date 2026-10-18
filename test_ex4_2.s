.data
a:  .word 10
b:  .word 8
c:  .word 0

CR: .word32 0x10000 ; coloca em R1 o valor de CR
DR: .word32 0x10008 ; COloca em R2 o valor de DR

.text
	lwu r1,CR(r0)
	lwu r2,DR(r0)
	
	daddi r10, r0,8
	
	sd r10, 0(R1)
	ld r4, 0(R2)
	
	sd r10, 0(R1)
	ld r5, 0(R2)
	
    ld  r4, a(r0)
    ld  r5, b(r0)    

    dadd  r3,r4,r5   
	
	sd r3,c(r0)
	sd r3,(r2)
	daddi r10,r0,1
	sd r10,(r1)
	
	halt
	