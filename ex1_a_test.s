.data
a: .word 10
b: .word 8
c: .word 0
z: .word 2


.text
main:
	ld r4, a(r0)
	ld r5, b(r0)
	ld r7, z(r0)
	
	dadd r3, r4, r5
	dadd r8, r3, r7
	
	sd r8, c(r0)