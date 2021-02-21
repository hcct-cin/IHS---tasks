bootdisk=disk.img
blocksize=512
disksize=100

boot1=boot1

# preencha esses valores para rodar o segundo estágio do bootloader
boot2=boot2
boot2pos=1
boot2size=1

# preencha esses valores para rodar o kernel
atividade1=atividade1
atividade1pos=2
atividade1size=4

file = $(bootdisk)

# adicionem os targets do kernel e do segundo estágio para usar o make all com eles

atividade: clean mydisk boot1 write_boot1 boot2 write_boot2 atividade1 write_atividade1 hexdump launchqemu

mydisk: 
	dd if=/dev/zero of=$(bootdisk) bs=$(blocksize) count=$(disksize) status=noxfer

boot1: 
	nasm -f bin $(boot1).asm -o $(boot1).bin 

boot2:
	nasm -f bin $(boot2).asm -o $(boot2).bin 

atividade1:
	nasm -f bin $(atividade1).asm -o $(atividade1).bin

write_boot1:
	dd if=$(boot1).bin of=$(bootdisk) bs=$(blocksize) count=1 conv=notrunc status=noxfer

write_boot2:
	dd if=$(boot2).bin of=$(bootdisk) bs=$(blocksize) seek=$(boot2pos) count=$(boot2size) conv=notrunc status=noxfer

write_atividade1:
	dd if=$(atividade1).bin of=$(bootdisk) bs=$(blocksize) seek=$(atividade1pos) count=$(atividade1size) conv=notrunc


hexdump:
	hexdump $(file)

disasm:
	ndisasm $(boot1).asm

launchqemu:
	qemu-system-i386 -fda $(bootdisk)
	
clean:
	rm -f *.bin $(bootdisk) *~