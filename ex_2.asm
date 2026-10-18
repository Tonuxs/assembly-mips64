	.data
a: .word 10
b: .word 8

	.text ; .code
main:
	ld r4, a(r0)
	ld r5, b(r0)
	sd r5, a(r0)
	sd r4, b(r0)