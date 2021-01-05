[bits 64]

section .text

exit:
	mov rax,60
	mov rdi,0
	syscall ;int 80h

openfile:
	mov eax, 2 			; open syscall
	mov rdi, filename   ; path
	mov esi, 0 			; O_RDOLNY
	syscall
	mov [file], eax 	;storing fd in file variable
	ret

closefile:
	mov rdi, [file]
	mov rax, 3 
	syscall
	ret

read:
	mov eax, 0 ; write syscall
	mov esi, buf ; write syscall
	mov edx, buflen ; write syscall
	syscall
	ret

print:
	mov eax, 1   ; write syscall
	mov edi, 1 	 ; stdout 
	mov esi, buf ; write syscall
	;mov edx, -- ; set by caller
	syscall
	ret

