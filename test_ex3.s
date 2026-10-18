.data
a:  .word 10
b:  .word 8
c:  .word 0

CR: .word32 0x10000
DR: .word32 0x10008

.text
main:
	lwu r1,CD(r0)
	lwu r2,DR(r0)

    ld  r4,a(r0)
    ld  r5,b(r0)    
    ld  r6,c(r0)

    dadd  r3,r4,r5
	
	sd r3,c(r0)
	sd r3, (r2)
	daddi r10,r0,1
	sd r10,(r1)
	halt
	