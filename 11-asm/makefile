
main: main.o
	ld $< -o $@

main.o : main.asm fileops.asm
	nasm -f elf64 $<

run: small.txt
	./main small.txt

clean:
	rm *.o
