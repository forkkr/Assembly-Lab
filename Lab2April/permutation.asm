segment .data
	scfmt: dq "%lld",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "checked",10,0
segment .bss
	a: resq 1
	b: resq 1
	array: resq 111
	
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

	xor rcx , rcx
	push rcx	
build_array:
	pop rcx
	push rcx
	cmp rcx , [a]
	je call_function
	pop rcx
	inc rcx
	mov [array + rcx*8 - 8] , rcx
	push rcx
	jmp build_array
		
	;push parameter and call function
call_function:
	pop rcx
	xor rbx , rbx
	push rbx
	
	call permutation
			
       	pop rbx
	pop rbp
	ret
	
permutation:
        ;update base pointer
        push rbp
        mov rbp , rsp

        ;base case handle
        mov rbx , [rbp+16]
        cmp rbx , [a]
        je _exit
        
	mov rbx , [rbp+16]
	push rbx
inner_loop:
	pop rbx
	cmp rbx, [a]
	je looop_exit
	push rbx			;push current position
					;swap ar[at] and ar[i]
	mov r8 , [rbp+16]
	mov rcx , [array + rbx*8]	;rcx = ar[i]
	mov rdx , [array + r8*8]	;rdx = ar[at]	
	mov [array+r8*8] , rcx		;ar[at] = rcx 
	mov [array+rbx*8] , rdx		;ar[i] = rdx
	
	
	mov rax , [rbp+16]		;increment value of at variable
	add rax , 1			
	push rax			;push incremented at
	
	
	call permutation		;call function for next position
	
	
	pop rdx				;argument for next function call
	pop rbx				;pop current position value
					;undo swap
	mov r8 , [rbp+16]		
	mov rcx , [array + rbx*8]
	mov rdx , [array + r8*8]
	mov [array+r8*8] , rcx
	mov [array+rbx*8] , rdx
	
	inc rbx			;increment current position value
	push rbx
	jmp inner_loop		;jump to loop starting point
looop_exit:
        pop rbp
        ret
_exit:
		
	xor rbx , rbx
print_permutation:
	cmp rbx , [a]
	je  function_exit

	xor rax , rax
	mov rdi , fmt
	mov rsi , [array + rbx*8]
	call printf
	
	inc rbx
	jmp print_permutation
	
function_exit:
	;print extra newline 
	xor rax,rax
	mov rdi, prr
	call printf
	pop rbp
	ret
	
