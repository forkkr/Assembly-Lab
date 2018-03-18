segment .data
	fmt: dq "%lld %lld",10, 0
	scfmt: dq "%lld %lld",0
	prfmt: dq "%lld ",10 , 0
	sumfmt: dq "Difference: %lld",10,0
	prr: dq "",10,0
	ppfmt: dq "Prime(s): ",10,0

segment .bss
	prime: resq 100
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

	mov rdi , scfmt
	mov rsi , l
	mov rdx , r
	xor rax , rax
	call scanf

	xor rcx , rcx
	mov rcx , [l]

	xor r8 ,r8
	mov [pcon] , r8
	mov [cnt] , r8

main_loop:
	mov [main_con] , rcx
	mov qword[parameter] , rcx
	call proc
	mov rdx , [r]
	mov rcx, [main_con]
	cmp rcx , rdx
	je prime_print
	mov rcx , [main_con]
	inc rcx
	jmp main_loop


prime_print:
	xor rax , rax
	mov rdi , ppfmt
	call printf	

	xor rax , rax
	mov [sum1] , rax
	mov [sum2] , rax
	xor r8 , r8
	mov [cnt] , r8

print_loop:
	mov [cnt] , r8
	mov r9 , [pcon]
	cmp r9 , r8
	je _exit

	mov r8, [cnt]
	xor rax , rax
	mov rdi , prfmt
	mov rsi , [prime + r8*8]
	call printf

	mov r8 , [cnt]
	and r8 , 1
	cmp r8 , 0
	je add_odd_position_prime
	mov r11 , [sum1]
	mov r8 , [cnt]
	add r11 , [prime + 8*r8]
	mov [sum1] , r11
	jmp print_loop_con

add_odd_position_prime:
	mov r11 , [sum2]
	mov r8 , [cnt]
	add r11 , [prime + 8*r8]
	mov [sum2] , r11

print_loop_con:
	mov r8 , [cnt]
	inc r8
	mov [cnt] , r8
	jmp print_loop


_exit:
	xor rax , rax
	mov rdi , prr
	call printf

	mov rax , [sum1]
	mov rbx , [sum2]
	cmp rax , rbx
	jge result
	mov rax , [sum2]
	sub rax , [sum1]
	jmp show
	result:
	mov rax , [sum1]
	sub rax , [sum2]

show:
	
	mov rdi , sumfmt
	mov rsi,rax
	call printf

	pop RBP
	ret


proc:
	mov r9 , 2

	mov [proc_con] , r9
	mov r10 , [parameter]
	cmp r9, r10
	jg chk_exit

	mov r9 , [proc_con]
	mov r10 , [parameter]
	cmp r9, r10
	je addPrimeToList

chkloop:
	mov [proc_con] , r9
	mov rax , [parameter]
	xor rdx ,rdx
	div r9
	cmp rdx , 0
	je chk_exit

	mov r9, [proc_con]
	inc r9
	mov [proc_con] , r9
	mov r10 , [parameter]
	cmp r9, r10
	jne chkloop

addPrimeToList:
	mov r8 , [pcon]
	mov r10 , [parameter]
	mov [prime + 8*r8] , r10
	inc r8
	mov [pcon] , r8


chk_exit:
	ret
