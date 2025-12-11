    .section .exception_vectors, "ax"
    .align 11
    .global exception_vectors
exception_vectors:

    // EL1t Sync
    adrp x2, el_entry
    add  x2, x2, :lo12:el_entry
    br   x2

    // EL1t IRQ
    adrp x2, el_entry
    add  x2, x2, :lo12:el_entry
    br   x2

    // EL1t FIQ (unused)
    b .

    // EL1t SError (unused)
    b .

    // EL1h Sync
    adrp x2, el_entry
    add  x2, x2, :lo12:el_entry
    br   x2

    // EL1h IRQ
    adrp x2, el_entry
    add  x2, x2, :lo12:el_entry
    br   x2

    // EL1h FIQ (unused)
    b .

    // EL1h SError (unused)
    b .

    // EL0_64 & EL0_32 entries (route remaining slots to same handler)
    .rept 8
        adrp x2, el_entry
        add  x2, x2, :lo12:el_entry
        br   x2
    .endr

    .align 7
el_entry:
    // 保存 caller-saved registers we will clobber (x0-x3)
    stp x0, x1, [sp, #-16]!
    stp x2, x3, [sp, #-16]!

    // 调用 C handler (exception_handler will do mrs ESR/ELR/FAR)
    adrp x4, exception_handler
    add  x4, x4, :lo12:exception_handler
    blr  x4

    // 恢复并返回
    ldp x2, x3, [sp], #16
    ldp x0, x1, [sp], #16
    eret