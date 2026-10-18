.data
a:  .word 10
b:  .word 8
c:  .word 0


.text
main:
    ld  r4, a(r0)
    ld  r5, b(r0)    
    ld  r6, c(r0)

    dadd  r3,r4,r5,r6   
	
	sd r3,c(r0)
	