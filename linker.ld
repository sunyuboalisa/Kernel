ENTRY(_start)

SECTIONS {
    . = 0x40000000;   /* QEMU virt 机器加载地址 */

    /* 启动入口放在最前 */
    .text : {
        KEEP(*(.text._start))
        *(.text*)
    }

    /* 异常向量（2KB 对齐） */
    . = ALIGN(2048);
    .exception_vectors : {
        KEEP(*(.exception_vectors))
    }

    .rodata : { *(.rodata*) }
    .data : { *(.data*) }

    . = ALIGN(8);
    .bss : {
        *(.bss*)
        *(COMMON)
    }

    /* 128KB 栈顶符号（供 boot.S 使用） */
    _stack_top = . + 0x20000;
}