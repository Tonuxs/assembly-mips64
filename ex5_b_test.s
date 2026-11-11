.data
A: .word 0
B: .word 0
CR: .word32 0x10000
DR: .word32 0x10008
MSG: .asciiz "iguais"

.text
lwu r1, CR(r0)
lwu r2, DR(r0)

daddi r10, r0, 8
sd r10, 0(r1)
ld r3, 0(r2)
sd r3, A(r0)

sd r10, 0(r1)
ld r4, 0(r2)
sd r4, B(r0)

bne r3, r4, Naofaz

daddi r10, r0, MSG
sd r10, 0(r2)
daddi r10, r0, 4
sd r10, 0(r1)

Naofaz:
halt