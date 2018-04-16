segment .data
	scfmt: dq "%s",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	chk: dq "checked",10,0
	balanced: dq "Color Balanced", 10 , 0
	notbalanced: dq "Not Balanced",10,0
	
segment .bss
	B: resq 1
	G: resq 1
	R: resq 1
	Y: resq 1
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
	mov rbx , rcx
	mov al , [str+rcx]
	cmp al , 0
	je _exit
	
	cmp al , 66
	je b_count
	cmp al , 71
	je g_count
	cmp al , 82
	je r_count
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
	pop rcx
	inc rcx
	push rcx
	jmp build_array
		
_exit:
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
	pop rbp
	ret
	
