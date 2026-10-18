.data
c:  .word 0
CR: .word32 0x10000
DR: .word32 0x10008

.text
    lwu r1, CR(r0)
    lwu r2, DR(r0)

    daddi r10, r0, 8

    sd r10, 0(r1)
    ld r4, 0(r2)

    sd r10, 0(r1)
    ld r5, 0(r2)

    dadd r3, r4, r5
    sd r3, c(r0)

    sd r3, 0(r2)
    daddi r10, r0, 2
    sd r10, 0(r1)

    halt