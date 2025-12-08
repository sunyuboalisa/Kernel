    .section .text
    .global _start
_start:
    // 跳转到 C 内核入口
    bl kernel_main

1:  wfe         // 低功耗等待
    b 1b         // 无限循环