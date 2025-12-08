CC = aarch64-elf-gcc
LD = aarch64-elf-ld
OBJCOPY = aarch64-elf-objcopy

CFLAGS = -ffreestanding -O2 -nostdlib -nostartfiles
LDFLAGS = -T linker.ld

all: kernel.bin

kernel.elf: boot.o kernel.o
	$(LD) $(LDFLAGS) -o kernel.elf boot.o kernel.o

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

run: all
	qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.bin

clean:
	rm -f *.o kernel.elf kernel.bin