segment .data
	scfmt: dq "%lld %lld",0
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
	mov rdx , b
	call scanf
	
	;push parameter and call function
	mov rbx , [a]
	mov rcx , [b]
	cmp rbx , rcx
	je done
	mov rax , rbx
	mov rbx , rcx
	mov rcx , rax
done:
	push rbx
	push rcx
	call gcd

        
        ;print factorial 
        mov rdi , fmt
	mov rsi , rax
	xor rax , rax
	call printf        
        
        ;print extra newline 
	mov rdi, prr
	xor rax,rax
	call printf
	
	leave
	ret
	

gcd:
        ;update base pointer
        push rbp
        mov rbp , rsp
        sub rsp , 32
        
        mov rbx , [rbp+16]
        mov rax , [rbp+24]
          
        cmp rbx , 0
        je _exit

        xor rdx , rdx
        div rbx
        
        ;push b and a%b respectively
        push rbx
        push rdx
        call gcd
       
       
        leave
        ret
_exit:
        mov rax , [rbp+24]
        leave
        ret

