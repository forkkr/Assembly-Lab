segment .data
	scfmt: dq "%s",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "checked",10,0
	balanced: dq "Balanced", 10 , 0
	notbalanced: dq "Not Balanced",10,0
	
segment .bss
	a: resq 1
	b: resq 1
	str: resb 111
	B: resq 1
	G: resq 1
	R: resq 1
	Y: resq 1
	
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

	xor rbx , rbx
	push rbx
	call checking
			
	mov r8, [R]
	mov r9, [G]
	mov r10, [Y]
	mov r11, [B]
	
	cmp r8, r9
	jne notbalanced_print
	cmp r10, r11
	jne notbalanced_print
	
	xor rax ,rax
	mov rdi , balanced
	call printf
	
	xor rax ,rax
	mov rdi, prr
	call printf
	jmp the_end
notbalanced_print:
	xor rax ,rax
	mov rdi , notbalanced
	call printf
	
	xor rax ,rax
	mov rdi, prr
	call printf
the_end:
	pop rbx
	pop rbp
	ret
	


;here 
checking:
	;update base pointer
	push rbp
	mov rbp , rsp

	;base case handle
	mov r12 , [rbp+16]
	mov al , [str+r12]
	cmp al , 0
	je checking_end
	
	
	mov r12 , [rbp+16]
	inc r12
	push r12
	
	call checking
	mov r12 , [rbp+16]
	mov al , [str+r12]
	cmp al , 66
	je b_count
	
	mov r12 , [rbp+16]
	mov al , [str+r12]
	cmp al , 71
	je g_count
	
	mov r12 , [rbp+16]
	mov al , [str+r12]
	cmp al , 82
	je r_count
	
	mov r12 , [rbp+16]
	mov al , [str+r12]
	cmp al , 89
	je y_count

b_count:
	mov rdx , [B]
	add rdx , 1
	mov [B], rdx
	jmp loop_control
	
g_count:
	mov rdx , [G]
	add rdx , 1
	mov [G], rdx
	jmp loop_control

r_count:
	mov rdx , [R]
	add rdx , 1
	mov [R], rdx
	jmp loop_control
	
y_count:
	mov rdx , [Y]
	add rdx , 1
	mov [Y], rdx
	jmp loop_control


loop_control:
	pop rbx
	pop rbp
	
	ret
	

checking_end:
	
	pop rbp
	
	xor r8 , r8
	xor r9 , r9
	xor r10 , r10
	xor r11 , r11
	mov [B] , r8
	mov [G] , r8
	mov [R] , r8
	mov [Y] , r8
		
	ret
	
