#include "types.h"

extern char exception_vectors[];

void init_exceptions(void) {
    uintptr addr = (uintptr)exception_vectors;
    asm volatile("msr VBAR_EL1, %0" :: "r"(addr) : "memory");
    asm volatile("isb");
}