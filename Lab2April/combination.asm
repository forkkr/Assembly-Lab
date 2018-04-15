segment .data
	scfmt: dq "%lld %lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "here",10,0
	
	
segment .bss
	n: resq 1
	taken: resq 1
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
	mov r8 , 1
	push r8
	xor rax ,rax
	mov [taken] , rax
	call combination
				;pop parameter and base pointer
	pop r8
	pop rbp
				;return 0
	ret
	
combination:				
				;update base pointer
	push RBP
        mov RBP , RSP
        	
        			;check taken is equal to r or not
       	mov r8 , [r]
       	mov r9 , [taken]
        cmp r8 , r9
        je print_combination
        			;check the parameter is greater than n or n
        mov r8 , [rbp+16]
        cmp r8 , [n]
        jg _the_end
        			;this value will be taken in combination
        mov r9 ,[taken]
        mov [array+r9*8] , r8;
       	inc r8
        inc r9
        mov [taken] , r9
        push r8
        call combination	;call function for pos+1
        
        mov r9 , [taken]	;this value will not be taken in combination
        dec r9
        mov [taken] , r9
        call combination	;call functioin for pos+1 without taking this value
        pop r8
        pop rbp
        ret
        
print_combination:
	xor rbx , rbx
inner_loop:
	cmp rbx, [r]
	je _the_loop_end
	
	xor rax , rax
	mov rdi	, fmt
	mov rsi , [array + rbx*8]
	call printf
	
	inc rbx
	jmp inner_loop
_the_loop_end:
	xor rax , rax
	mov rdi , prr
	call printf
	jmp _the_end
_the_end:
	pop rbp
	ret
