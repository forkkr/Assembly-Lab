segment .data
	scfmt: dq "%lld",0
	prfmt: dq "*",10
	spfmt: dq " ",10
	prr: dq "",10 , 0
	fmt: dq "%lld",10	
segment .bss
	proc_con: resq 1
	main_con: resq 1
	parameter: resq 1
	cnt: resq 1
	print_con: resq 1
	

segment .text
	global main
	extern scanf
	extern printf

main:
	push RBP

	xor rax , rax
	mov rdi , scfmt
	mov rsi , cnt
	call scanf

	mov rax , [cnt]
	cmp rax , 0
	je _exit
	
	mov rax , [cnt]
	cmp rax , 1
	je _upExit
	
	xor rax, rax
	mov rdi , prfmt
	call printf
	
	xor rax ,rax
	mov rdi , prr
	call printf
	
	mov rcx , 2
	mov [main_con] , rcx
main_loop:
	mov rdx , [cnt]
	cmp rcx , rdx
	je last_line

	mov rcx , [main_con]
	mov [parameter] , rcx
	call proc

	mov rcx, [main_con]
	inc rcx
	mov [main_con] , rcx
	jmp main_loop

last_line:
	mov rcx , 0
	mov [print_con] , rcx

print_loop:
	mov r8 , [cnt]
	mov r9 , [print_con]
	cmp r9 , r8
	je _exit
	xor rax , rax
	mov rdi , prfmt
	call printf
	mov r9 , [print_con]
	inc r9
	mov [print_con] , r9
	jmp print_loop


proc:
	xor rax , rax
	mov rdi , prfmt
	call printf
	
	mov r9 , 2
	mov [proc_con] , r9

chkloop:
	
	mov rax , [parameter]
	mov rbx , [proc_con]
	cmp rax , rbx
	je proc_exit

	xor rax ,rax
	mov rdi , spfmt
	call printf
	
	mov r9, [proc_con]
	inc r9
	mov [proc_con] , r9
	jmp chkloop

proc_exit:
	xor rax , rax
	mov rdi , prfmt
	call printf
	
	xor rax , rax
	mov rdi , prr
	call printf
	ret


_upExit:
	xor rax ,rax
	mov rdi , prfmt
	call printf

_exit:
	xor rax ,rax
	mov rdi , prr
	call printf
	pop RBP
	ret

