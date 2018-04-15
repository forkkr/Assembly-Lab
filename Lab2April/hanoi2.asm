segment .data
	scfmt: db "%lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	cmt: dq "%c",10,0
	chk: dq "here",10,0
	pmt: dq "Move Disk %lld from Stick %lld to Stick %lld",10,0
	
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
	mov r9 , 1
	mov r10 , 3
	mov r11 , 2
	
	push r8
	push r9
	push r10
	push r11
	
	call hanoi
	pop r11
	pop r10
	pop r9
	pop r8
	pop rbp
	
	ret
hanoi:
	push rbp
	mov rbp , rsp
	
	mov r8 , [rbp+40]
	mov r9 , [rbp+32]
	mov r10 , [rbp+24]
	mov r11 , [rbp+16]

	cmp r8 , 1
	je one_return
	
	mov r8 , [rbp+40]
	mov r9 , [rbp+32]
	mov r10 , [rbp+24]
	mov r11 , [rbp+16]
	sub r8 , 1
	
	push r8
	push r9
	push r11
	push r10
	
	call hanoi
	
	pop r10
	pop r11
	pop r9
	pop r8

	mov r8 , [rbp+40]
	mov r9 , [rbp+32]
	mov r10 , [rbp+24]
	mov r11 , [rbp+16]
	
	xor rax , rax
	mov rdi , pmt
	mov rsi , [rbp+40]
	mov rdx , r9
	mov rcx , r10
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	
	mov r8 , [rbp+40]
	mov r9 , [rbp+32]
	mov r10 , [rbp+24]
	mov r11 , [rbp+16]
	sub r8 , 1
	
	push r8
	push r11
	push r10
	push r9
	call hanoi
	
	pop r11
	pop r10
	pop r9
	pop r8
	pop rbp
	ret
one_return:
	mov r8 , [rbp+40]
	mov r9 , [rbp+32]
	mov r10 , [rbp+24]
	mov r11 , [rbp+16]
	
	xor rax , rax
	mov rdi , pmt
	mov rsi , r8
	mov rdx , r9
	mov rcx , r10
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	
	pop rbp
	ret
	
