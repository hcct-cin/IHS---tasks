obj-m+=hello.o

all:
	sudo make -C /lib/modules/5.8.0-48-generic/build M=$(pwd) modules
clean:
	sudo make -C /lib/modules/5.8.0-48-generic/build M=$(pwd) clean