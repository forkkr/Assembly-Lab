segment .data
fmt: dq "%lld ",10,0
ssfmt: dq "%lld",0


segment .bss
a: resq 255
b: resq 2
c: resq 2
d: resq 2
cn: resq 2

segment .text
global main
extern printf
extern scanf

main:
push RBP
xor rcx, rcx
mov [c] , rcx
xor rax , rax
mov rdi, ssfmt
mov rsi , cn
call scanf
ll:

mov rcx, [b]
mov rbx , rcx
xor rax, rax
mov rdi , ssfmt
mov rsi, d
call scanf
mov rax , [d]
mov [a+rbx*8],rax
xor rax , rax
add rax, [c]
add rax, [d]
mov [c], rax
mov rcx , [b]
INC rcx
mov [b], rcx
mov r8 , [cn]
cmp rcx ,r8
jl ll

pr:
xor rax , rax
mov rdi , fmt
mov rsi , [c]
call printf
pop RBP
ret

