typedef unsigned int u32;
typedef unsigned long u64;

// UART 输出（QEMU virt 机器）
void uart_putc(char c) {
    volatile u32 *UART0 = (volatile u32 *)0x09000000;
    while (*(UART0 + 0x18/4) & (1 << 5)); // TXFF
    *UART0 = c;
}

void uart_puts(const char *s) {
    while (*s) uart_putc(*s++);
}

void kernel_main() {
    uart_puts("Hello ARM64 Kernel!\n");

    // 内核主循环
    for (int i = 0; i < 10; i++) {
    uart_puts("Tick\n");
}
}