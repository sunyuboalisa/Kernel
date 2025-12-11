CC = aarch64-elf-gcc
LD = aarch64-elf-ld
OBJCOPY = aarch64-elf-objcopy

CFLAGS = -ffreestanding -O2 -nostdlib -nostartfiles -Wall -Wextra
LDFLAGS = -T linker.ld

OBJS = boot.o kernel.o uart.o exception.o exception_init.o exception_vectors.o

all: kernel.bin

kernel.elf: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary $< $@

boot.o: boot.S
	$(CC) $(CFLAGS) -c $< -o $@

exception_vectors.o: exception.S
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.bin

clean:
	rm -f *.o kernel.elf kernel.bin