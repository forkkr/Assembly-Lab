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
	call fact

        
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
	

fact:
        ;update base pointer
        push rbp
        mov rbp , rsp
        sub rsp , 32
        
        mov rbx , [rbp+16]
        cmp rbx , 0
        je _exit
        
        dec rbx
        push rbx
        call fact
        
        mov rbx, [rbp+16]
        mul rbx
       
        leave
        ret
_exit:
        mov rax , 1
        leave
        ret

