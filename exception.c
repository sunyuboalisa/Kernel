#include "types.h"
#include "uart.h"

void exception_handler(void) {
    u64 esr = 0, elr = 0, far = 0;
    asm volatile("mrs %0, ESR_EL1" : "=r"(esr));
    asm volatile("mrs %0, ELR_EL1" : "=r"(elr));
    asm volatile("mrs %0, FAR_EL1" : "=r"(far));

    uart_puts("\n[EXCEPTION] EL1\n");
    uart_puts(" ESR = "); uart_puthex(esr); uart_puts("\n");
    uart_puts(" ELR = "); uart_puthex(elr); uart_puts("\n");
    uart_puts(" FAR = "); uart_puthex(far); uart_puts("\n");

    while (1) { asm volatile("wfe"); }
}