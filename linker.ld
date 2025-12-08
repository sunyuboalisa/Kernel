ENTRY(_start)

SECTIONS {
    . = 0x40000000;   /* QEMU virt 机器加载地址 */
    .text : { *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(.bss*) *(COMMON) }
}