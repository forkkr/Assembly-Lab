segment .data
fmt: dq "%lld ",10,0
ffmt: dq "Sum: %lld ",10,0
ppp: dq "Numbers: ",10,0
prr: dq "",10,0
ssfmt: dq "%lld",0


segment .bss
a: resq 255
b: resq 2
c: resq 2
d: resq 2

segment .text
global main
extern printf
extern scanf

main:
push RBP

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
xor rax , rax
add rax, [c]
add rax, [d]
mov [c], rax
mov rcx , [b]
INC rcx
cmp rcx , 20
jne ll
xor rax , rax
mov rdi , ffmt
mov rsi , [c]
call printf

xor rax , rax
mov rdi , prr
call printf

xor rax, rax
mov rdi, ppp
call printf

xor rcx, rcx
sll:
mov [b] , rcx
mov rbx , [a+rcx*8]
xor rax , rax
mov rdi , fmt
mov rsi, rbx
call printf
mov rcx, [b]
INC rcx
cmp rcx , 20
jne sll
pop RBP
ret
