;Have to calculate n^r using bigmod
segment .data
	scfmt: dq "%lld %lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "here",10,0
	
	
segment .bss
	n: resq 1
	r: resq 1
	
segment .text
	global main
	extern scanf
	extern printf

main:
	push RBP
        mov RBP , RSP

	xor rax ,rax
	mov rdi , scfmt
	mov rsi , n
	mov rdx , r
	call scanf
				;push parameter and call bigmod function
	mov r8 , [n]
	mov r9 , [r]
	push r8
	push r9
	call bigmod
				;pop parameter and base pointer
	pop rbx
	pop r9
	pop r8
	pop rbp
				;print the result and new line
	xor rax ,rax
	mov rdi , fmt
	mov rsi , rbx
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
				;return 0
	ret
	
bigmod:				
				;update base pointer
	push RBP
        mov RBP , RSP
        	
        			;check taken is equal to r or not
       	mov r8 , [rbp+24]
       	mov r9 , [rbp+16]
        cmp r9 , 0
        je one_return
        			;do r = r/2
        xor rax , rax
        xor rdx , rdx
        mov rax , [rbp+16]
        mov rcx , 2
        div rcx
        			;push n and r/2
        push r8
        push rax
        call bigmod		;call bigmod for n and r/2

        pop rbx
        pop r9
        pop r8
        	
       				;do result = result*result
       	mov rax ,rbx
       	xor rdx ,rdx
       	mul rbx
       	mov rbx , rax	
       	
        	
        			; check r is odd or even
        xor rax , rax
        xor rdx , rdx
        mov rax , [rbp+16]
        mov rcx , 2
        div rcx
        cmp rdx , 0
        je skipped
        
        xor rax , rax
        xor rdx , rdx
        mov rax , [rbp+24]
        mul rbx
	mov rbx , rax
skipped:
	pop rbp
	pop rdx
	push rbx
	push rdx
	ret
one_return:
	pop rbp
	pop rdx
	mov rbx , 1
	push rbx
	push rdx
	ret
