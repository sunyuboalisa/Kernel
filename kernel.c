#include "types.h"
#include "uart.h"
#include "exception.h"

void kernel_main(void) {
    uart_init();
    uart_puts("Hello ARM64 Kernel!\n");

    init_exceptions();
    uart_puts("Exceptions inited\n");

    uart_puts("Tick (5 times):\n");
    for (int i = 0; i < 5; i++) {
        uart_puts("Tick\n");
        for (volatile int j = 0; j < 10000000; j++); // crude delay
    }

    // 若要测试异常处理：取消下面两行注释（读 0 地址）
    // volatile u32 *p = (volatile u32 *)0x0;
    // volatile u32 x = *p;

    uart_puts("End of kernel_main — entering wait loop\n");
    while (1) { asm volatile("wfe"); }
}