bootdisk=disk.img
blocksize=512
disksize=100

boot1=boot1

# preencha esses valores para rodar o segundo estágio do bootloader
boot2=boot2
boot2pos=1
boot2size=1

# preencha esses valores para rodar o kernel
AP2=AP2
AP2pos=2
AP2size=4

file = $(bootdisk)

# adicionem os targets do kernel e do segundo estágio para usar o make all com eles

atividade: clean mydisk boot1 write_boot1 boot2 write_boot2 AP2 write_AP2 hexdump launchqemu

mydisk: 
	dd if=/dev/zero of=$(bootdisk) bs=$(blocksize) count=$(disksize) status=noxfer

boot1: 
	nasm -f bin $(boot1).asm -o $(boot1).bin 

boot2:
	nasm -f bin $(boot2).asm -o $(boot2).bin 

AP2:
	nasm -f bin $(AP2).asm -o $(AP2).bin

write_boot1:
	dd if=$(boot1).bin of=$(bootdisk) bs=$(blocksize) count=1 conv=notrunc status=noxfer

write_boot2:
	dd if=$(boot2).bin of=$(bootdisk) bs=$(blocksize) seek=$(boot2pos) count=$(boot2size) conv=notrunc status=noxfer

write_AP2:
	dd if=$(AP2).bin of=$(bootdisk) bs=$(blocksize) seek=$(AP2pos) count=$(AP2size) conv=notrunc


hexdump:
	hexdump $(file)

disasm:
	ndisasm $(boot1).asm

launchqemu:
	qemu-system-i386 -fda $(bootdisk)
	
clean:
	rm -f *.bin $(bootdisk) *~
