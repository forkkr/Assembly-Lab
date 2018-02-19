segment .data
fmt: dq "%lld ",10,0
ssfmt: dq "%lld",0


segment .bss
a: resq 255
b: resq 1
c: resq 1
d: resq 1

segment .text
global main
extern printf
extern scanf

main:
push RBP

xor r8 , r8
xor rcx, rcx
mov [c] , rcx
ll:
mov rbx , rcx
mov [b], rcx
xor rax, rax
mov rdi , ssfmt
mov rsi, d
call scanf
mov rax , [d]
mov [a+rbx*8],rax
mov rcx , [b]
INC rcx
cmp rcx , 10
jne ll

xor rax, rax
mov rdi , ssfmt
mov rsi, d
call scanf
mov rax , [d]
mov rbx , [a+rax*8]
mov rdi , fmt
mov rsi , rbx
call printf
pop RBP
ret

