.data
CR: .word32 0x10000
DR: .word32 0x10008
MSG: .asciiz "Hello world"

.text
lwu r1, CR(r0)
lwu r2, DR(r0)

daddi r10, r0, MSG
sd r10, 0(r2)
daddi r3, r0, 4
sd r3, (r1)