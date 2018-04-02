segment .data
	scfmt: dq "%lld",0
	prr: dq "",10,0
	fmt: dq "%lld" , 10 ,0
segment .bss
	a: resq 1
	b: resq 1
	
segment .text
	global main
	extern scanf
	extern printf

main:
	push RBP
        mov RBP , RSP

	xor rax ,rax
	mov rdi , scfmt
	mov rsi , a
	call scanf
	
	;push parameter and call function
	mov rbx , [a]
	push rbx
	call fib

        
        ;print factorial
        pop rax
        mov rdi , fmt
	mov rsi , rax
	xor rax , rax
	call printf        
        
        ;print extra newline 
	mov rdi, prr
	xor rax,rax
	call printf
	
	pop rbx
	pop rdx
	ret
	

fib:
        ;update base pointer
        push rbp
        mov rbp , rsp

        
        mov rbx , [rbp+16]
        cmp rbx , 1
        je _exit
        
        mov rbx , [rbp+16]
        cmp rbx , 0
        je _exit
        
                
        ;push b-1 
        dec rbx
        push rbx
        call fib
        pop rax
        
        ;push b-2 
        pop rbx
        dec rbx
        push rax
        push rbx
        call fib
        pop  rdx
        pop rbx
        pop rax
        add rax , rdx

        pop rbp
        pop rcx
        push rax
        push rcx
        ret
_exit:
        mov rdx , 1
        pop rbp
        pop rcx
        push rdx
        push rcx
        ret

