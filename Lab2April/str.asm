segment .data
	scfmt: db "%s",0
	prr: dq "",10,0
	fmt: dq "%lld",10,0
	cmt: dq "%c",10,0
	chk: dq "here",10,0
	
	
segment .bss
	n: resq 1
	r: resq 1
	str: resb 100
	prev: resb 10
	taken: resq 1
	idx: resq 1
	mx_len: resq 1
	mx_idx: resq 1
	
segment .text
	global main
	extern scanf
	extern printf
	extern gets
main:
	xor rax , rax		;get string
	mov rdi , str
	call gets
				;initialize
	xor rbx , rbx
	mov [idx] , rbx
	xor rbx , rbx
	mov [mx_len] , rbx
	xor rbx , rbx
	mov [mx_idx] , rbx
	mov dl , [str]
	mov [prev] , dl
	
	add rbx , 1
	mov [taken] , rbx
	
inner_loop:
	mov dl , [str+rbx]
	cmp dl , 0
	je _exit
				;check consecutive letters
	mov dl , [str+rbx]
	sub dl , 1
	
	mov cl , [prev]
	cmp cl , dl
	je skipped		; if letters are consecutive then skipped the next parts 
	
	mov rdx , [taken]	;if letters are not consecutive then update maximum length we get so far
	cmp rdx , [mx_len]	
	jl notupdate
	mov rdx , [taken]	;if current length is maximum then update the mx_len and mx_idx
	mov [mx_len] , rdx
	mov rdx , [idx]
	mov [mx_idx] , rdx
	
notupdate:
	mov dl , [str+rbx]	;set this letter value - 1 to prev variable
	sub rdx , 1
	mov [prev], dl
	
	mov [idx], rbx
	mov rdx , 0
	mov [taken], rdx
	
skipped:
	mov rcx , [prev]
	add rcx , 1
	mov [prev] , rcx
		
	mov rdx , [taken]
	add rdx , 1
	mov [taken], rdx
	
	inc rbx
	jmp inner_loop
_exit:
	
	mov rdx , [taken]	
	cmp rdx , [mx_len]	
	jl print_loop
	mov rdx , [taken]	
	mov [mx_len] , rdx
	mov rdx , [idx]
	mov [mx_idx] , rdx

print_loop:
	mov rcx , [mx_len]
	cmp rcx , 0
	je the_end
	
	mov rcx, [mx_idx]
	mov dl , [str+rcx]
	
	xor rax , rax
	mov rdi , cmt
	mov rsi , rdx
	call printf

	mov rdx , [mx_idx]
	inc rdx
	mov [mx_idx] , rdx
	
	mov rdx , [mx_len]
	dec rdx
	mov [mx_len] , rdx
	jmp print_loop
the_end:
	xor rax , rax
	mov rdi , prr
	call printf
	ret
