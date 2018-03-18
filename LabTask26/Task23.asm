segment .data
	scfmt: dq "%lld",0
	prfmt: dq "%lld ",10 , 0

segment .bss
	array: resq 100
	proc_con: resq 1
	main_con: resq 1
	parameter: resq 1
	l: resq 1
	r: resq 1
	cnt: resq 1
	print_con: resq 1
	pcon: resq 1
	sum1: resq 1
	sum2: resq 1

segment .text
	global main
	extern scanf
	extern printf

main:
	push RBP

	xor rcx , rcx
	mov [cnt] , rcx

main_loop:
	xor rax , rax
	mov rdi , scfmt
	mov rsi , parameter
	call scanf

	call proc
	mov rax , [cnt]
	cmp rax , 10
	jne main_loop


	xor rcx, rcx

print_loop:
	mov rcx , [main_con]
	xor rax , rax
	mov rdi , prfmt
	mov rsi , [array + rcx*8]
	call printf

	mov rcx , [main_con]
	inc rcx
	mov [main_con] , rcx
	mov rax , [cnt]
	cmp rax , rcx
	jne print_loop

	pop RBP
	ret


proc:
	mov r9 , 0

chkloop:
	mov [proc_con] , r9
	mov r10 , [cnt]
	cmp r9, r10
	je add_new_number
	mov r9 , [proc_con]
	mov rax , [parameter]
	mov rdx , [array+r9*8]
	cmp rdx , rax
	je chk_exit
	mov r9, [proc_con]
	inc r9
	mov [proc_con] , r9
	jmp chkloop
add_new_number:
	mov rax , [parameter]
	mov r10 , [cnt]
	mov [array + r10*8] , rax
	inc r10
	mov [cnt] , r10

chk_exit:
	ret

