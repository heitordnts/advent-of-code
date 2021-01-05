[bits 64]

%include "fileops.asm"

section .data
	filename: db "small.txt"
	x: dw 0
	y: dw 0
	rowlen: dw 0
	lines: dw 0

section .bss
	file: resw 1
	buflen: equ 1
	buf: resb buflen
	grid: resb 100*100

section .text

global _start

_start:
	call openfile
	call solve1
	call closefile
	call exit

solve1:
	mov edi, [file] ; file fd 

;while(ret = read_char(&c) && ret != -1){
loop:
	call read       ; eax is number of bytes read
	mov edx, eax    ; read return value
	cmp eax,-1
	je eof
	cmp [buf], 10   ; if( c == '\n'){
	jne store_on_grid
	;mov eax,[x]
	;mov [rowlen],eax
	;add [lines], 1  ; lines++
	;mov [x],0
store_on_grid:
	;lea ebx,[grid + lines*100 + x]
	lea ebx,[grid + lines*100 + x]
	jmp loop
eof:
	ret

