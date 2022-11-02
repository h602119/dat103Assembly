all: words-reverse-ll

words-reverse-ll.o: words-reverse-ll.asm reverseInputLines.asm readLine.asm macros.asm
	nasm -f elf -F dwarf -g $<

words-reverse-ll: words-reverse-ll.o
	ld -m elf_i386 -o $@ $<
