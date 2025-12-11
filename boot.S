    .section .text._start, "ax"
    .align 7
    .global _start

_start:
    // 初始化 SP（使用 linker.ld 中定义的 _stack_top）
    ldr x0, =_stack_top
    mov sp, x0

    // 调用 C 的 kernel_main（使用 bl 以便返回到 _start 后可继续）
    bl kernel_main

1:
    wfe
    b 1b