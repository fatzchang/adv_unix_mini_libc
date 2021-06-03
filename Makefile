all:
	mkdir -p build
	yasm -f elf64 -DYASM -D__x86_64__ -DPIC libmini64.asm -o build/libmini64.o
	gcc -c -o build/libmini.o -g -Wall -fno-stack-protector -fPIC -nostdlib libmini.c
	ld -shared -o libmini.so build/libmini64.o build/libmini.o
	yasm -f elf64 -DYASM -D__x86_64__ -DPIC start.asm -o start.o

.PHONY: test
test:	
	gcc -c -o test/test.o -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI test/test.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o test/test test/test.o start.o -L. -L.. -lmini

.PHONY: clean
clean:
	rm -rf build
	rm libmini.so start.o 
	rm test/test test/test.o

run:
	LD_LIBRARY_PATH=. ./test/test