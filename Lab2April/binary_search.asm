segment .data
	scfmt: dq "%lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "here",10,0
	found: dq "Found. Index: %lld",10,0
	notfound: dq "Not Found.",10,0
	
segment .bss
	n: resq 1
	a: resq 1
	array: resq 111
	k: resq 1
	
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
	call scanf

	xor rcx , rcx
	push rcx	
build_array:
	pop rcx
	push rcx
	cmp rcx , [n]
	je call_function
	
	xor rax , rax
	mov rdi , scfmt
	mov rsi , a
	call scanf
	
	mov rdx , [a]
	
	pop rcx
	inc rcx
	mov [array + rcx*8 - 8] , rdx
	push rcx
	jmp build_array
		
	;push parameter and call function
call_function:
	pop rcx
	
	xor rax , rax
	mov rdi , scfmt
	mov rsi , k
	call scanf
	
	xor rbx , rbx
	push rbx
	mov rbx , [n]
	dec rbx
	push rbx
	call binary_search
			
       	jmp _the_end
	
binary_search:
        				;update base pointer
        push rbp
        mov rbp , rsp
        				;base case handle
        
        mov r8 , [rbp+24]
        mov r9 , [rbp+16]		
        cmp r8 , r9
        jg _end
        
        xor rax , rax
        add rax , r8
        add rax , r9
        xor rdx , rdx
        mov rbx , 2
        div rbx
        
        mov rdx , [array+rax*8]
        cmp rdx , [k]
        je print_exit
        
        cmp rdx , [k]
        jg left_call
        
        cmp rdx , [k]
        jl right_call
        
        
left_call:
	dec rax
	push r8
	push rax
	call binary_search
	jmp _the_end
	
right_call:
	inc rax
	push rax
	push r9
	call binary_search
	jmp _the_end
	
print_exit:
	mov rdi , found
	mov rsi , rax
	xor rax , rax
	call printf
	
	xor rax, rax
	mov rdi , prr
	call printf
	
	pop rbp
	ret
	
_the_end:
	pop r9
	pop r8
	pop rbp
	ret
	
_end:
	mov rdi , notfound
	xor rax , rax
	call printf
	
	xor rax, rax
	mov rdi , prr
	call printf
	
	pop rbp
	ret
