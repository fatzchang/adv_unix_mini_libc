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
	rm test/test.o
alarm1:
	gcc -c -o test/alarm1.o -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI test/alarm1.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o test/alarm1 test/alarm1.o start.o -L. -L.. -lmini
	rm test/alarm1.o
alarm2:
	gcc -c -o test/alarm2.o -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI test/alarm2.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o test/alarm2 test/alarm2.o start.o -L. -L.. -lmini
	rm test/alarm2.o
alarm3:
	gcc -c -o test/alarm3.o -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI test/alarm3.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o test/alarm3 test/alarm3.o start.o -L. -L.. -lmini
	rm test/alarm3.o
jmp1:
	gcc -c -o test/jmp1.o -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI test/jmp1.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o test/jmp1 test/jmp1.o start.o -L. -L.. -lmini
	rm test/jmp1.o


.PHONY: clean
clean:
	rm -rf build
	rm libmini.so start.o 

run-alarm1:
	LD_LIBRARY_PATH=. ./test/alarm1
run-alarm2:
	LD_LIBRARY_PATH=. ./test/alarm2
run-alarm3:
	LD_LIBRARY_PATH=. ./test/alarm3
run-jmp1:
	LD_LIBRARY_PATH=. ./test/jmp1