#pragma once
#include "types.h"

void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
void uart_puthex(u64 x);