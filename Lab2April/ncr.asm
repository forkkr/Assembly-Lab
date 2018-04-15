segment .data
	scfmt: dq "%lld %lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "here",10,0
	found: dq "Found. Index: %lld",10,0
	notfound: dq "Not Found.",10,0
	
segment .bss
	n: resq 1
	a: resq 1
	array: resq 111
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
				;push parameter and call NCR function
	mov r8 , [n]
	mov r9 , [r]
	push r8
	push r9
	call NCR
				;pop parameter , result value and base pointer
	pop rbx
	pop r9
	pop r8
	pop rbp
				;print result with extra newline
	xor rax , rax
	mov rdi , fmt
	mov rsi , rbx
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
				;return 0
	ret
	
NCR:				
				;update base pointer
	push RBP
        mov RBP , RSP
        			;pop parameter n and r
        mov r8 , [rbp+24]
        mov r9 , [rbp+16]
        			;check n and r is equal or not
        cmp r8 , r9	
        je one_return
        			; check r is equal to zero or not
        cmp r9 , 0
        je one_return
        			;push n-1 and r and call NCR funtion
        dec r8
        push r8
        push r9
        call NCR

        pop rax			;pop return result to rax
        pop r9			;pop r to r9
        pop r8			;pop n-1 to r8
        push rax		;push result to use later
        push r8
        dec r9			;update r to r-1
        push r9	
        call NCR		;call NCR function
        
        pop rax			;pop recently calculated result
        pop r9			;pop r	
        pop r8			;pop n
        pop rbx			;pop previous calculated result
        add rax , rbx		;add both result to got final result
	pop rbp			;pop RBP
	pop rdx			;pop ret
	push rax		;push final result
	push rdx		;push ret
	ret			; return 0
one_return:
	pop rbp		
	pop rdx
	mov rax , 1
	push rax
	push rdx
	ret
