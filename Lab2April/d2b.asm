 
extern	printf		
extern	scanf		
extern gets

SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",0
int: dq 0
char: db 0
out_str_fmt: db "%s",10,0
in_str_fmt:	 db "%s",0
out_char_fmt: db "%c",10,0
in_char_fmt:	 db "%c",0
strs: db 0

SECTION .bss
str: resb 100
arr: resq 100

 
SECTION .text
 
global main		
main:				
	push rbp
	mov rbp,rsp	

	call scan_int
	push rax
	call binary
	mov rsi, strs
	call print_str
 
 

	leave
	ret
 
 

 
binary:
	push rbp
	mov rbp,rsp
 
	mov rax,[rbp+16]
	cmp rax,0
	je return
 
	mov rdx,0
	mov rbx,2
	div rbx
	push rdx
	push rax
	call binary
	pop rax
	pop rax
	call print_int
 
 
	return:
	leave
	ret
 	
print_str:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov	rdi,out_str_fmt		         
	mov	rax,0		
    call printf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx	
    ret		
 
;scans 64 bit int and puts it on rax
scan_int:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,int_in_fmt
	mov rsi,int
	mov rax,0
    call scanf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
    mov rax,[int]
	ret
 
;print rax(64 bit int) 	
print_int:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,int_out_fmt
	mov rsi,rax
	mov rax,0
    call printf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
	ret
 
