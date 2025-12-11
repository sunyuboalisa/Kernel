#include "uart.h"

#define UART0_BASE   0x09000000UL
#define UART_DR      0x00
#define UART_FR      0x18
#define UART_FR_TXFF (1 << 5)

static volatile u32 *uart_base(void) {
    return (volatile u32 *)UART0_BASE;
}

void uart_init(void) {
    (void)uart_base();
}

void uart_putc(char c) {
    volatile u32 *FR = (volatile u32 *)(UART0_BASE + UART_FR);
    volatile u32 *DR = (volatile u32 *)(UART0_BASE + UART_DR);
    while (*FR & UART_FR_TXFF) { /* spin */ }
    *DR = (u32)c;
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') uart_putc('\r');
        uart_putc(*s++);
    }
}

void uart_puthex(u64 x) {
    const char *hex = "0123456789ABCDEF";
    uart_puts("0x");
    for (int i = (int)(sizeof(x) * 2 - 1); i >= 0; --i) {
        u32 v = (u32)((x >> (i * 4)) & 0xF);
        uart_putc(hex[v]);
    }
}