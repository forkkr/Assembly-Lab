segment .data
	scfmt: db "%lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	cmt: dq "%c",10,0
	chk: dq "here",10,0
	
	
segment .bss
	n: resq 1
	r: resq 1
	
segment .text
	global main
	extern scanf
	extern printf
main:
	push rbp
	mov rbp ,rsp
	
	xor rax , rax
	mov rdi , scfmt
	mov rsi , n
	call scanf
	
	mov r8 , [n]
	push r8
	call hanoi
	
	pop rbx
	pop r8
	pop rbp
	
	xor rax , rax
	mov rdi , fmt
	mov rsi , rbx
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	
	ret
hanoi:
	push rbp
	mov rbp ,rsp
	
	mov rbx , [rbp+16]
	cmp rbx , 1
	je one_return
	
	mov r8 , [rbp+16]
	sub r8 , 1
	push r8
	call hanoi
	pop rbx
	add rbx , 1
	pop r8
	push rbx
	push r8
	call hanoi
	pop rax
	pop r8
	pop rbx
	add rax , rbx
	pop rbp
	pop rdx
	push rax
	push rdx
	ret
one_return:
	pop rbp
	pop rdx
	push 1
	push rdx
	ret
	
