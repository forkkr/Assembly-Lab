segment .data
	scfmt: dq "%s",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "checked",10,0
	palin: dq "Palindrome", 10 , 0
	notpalin: dq "Not Palindrome",10,0
	
segment .bss
	a: resq 1
	b: resq 1
	str: resb 111
	
segment .text
	global main
	extern scanf
	extern printf

main:
	push RBP
    mov RBP , RSP

	xor rax , rax
	mov rdi , scfmt
	mov rsi , str
	call scanf

	xor rcx , rcx
	push rcx
		
build_array:
	pop rcx
	push rcx
	mov al , [str+rcx]
	cmp al , 0
	je call_function
	pop rcx
	inc rcx
	push rcx
	jmp build_array
		
	;push parameter and call function
call_function:
	pop rcx
	sub rcx , 1
	xor rbx , rbx
	push rbx
	push rcx
	call palindrome
			
	pop rcx
	pop rbx
	pop rbp
	ret
	
palindrome:
	;update base pointer
	push rbp
	mov rbp , rsp

	;base case handle
	mov r8 , [rbp+24]
	mov r9 , [rbp+16]
	cmp r8 , r9
	jg _palin_exit
	mov al , [str+r8]
	mov bl , [str+r9]
	cmp al , bl
	jne _not_palin_exit
	
    mov r8 , [rbp+24]
	mov r9 , [rbp+16]
	inc r8
	dec r9
	push r8
	push r9
	call palindrome
	pop r9
	pop r8
	pop rbp
	ret

_not_palin_exit:
	xor rax , rax
	mov rdi , notpalin
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	
	pop rbp
	ret
	   
_palin_exit:
	xor rax , rax
	mov rdi , palin
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	
	pop rbp
	ret
	
