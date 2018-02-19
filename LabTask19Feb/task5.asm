segment .data
fmt: dq "Value %lld index %lld ",10,0
ssfmt: dq "%lld",0


segment .bss
a: resq 255
b: resq 1
c: resq 1
d: resq 1
cnt:  resq 2
now: resq 2

segment .text
global main
extern printf
extern scanf

main:
push RBP
xor rcx, rcx
ll:
mov rbx , rcx
mov [b], rcx
xor rax, rax
mov rdi , ssfmt
mov rsi, d
call scanf
mov rax , [d]
mov qword[a+rbx*8],rax
mov rcx , [b]
INC rcx
cmp rcx , 5
jne ll

xor rbx , rbx
mov r8 , 0
mov [d] , r8
mov rbx , [a]
mov [b] , rbx
mov rcx  , 1
first:
mov [c], rcx
mov rax , qword[a+rcx*8]
mov rdx , [b]
cmp rax , rdx
jg first_con
mov [b],rax
mov rcx , [c]
mov [d] , rcx
first_con:
INC rcx
cmp rcx , 5
jne first

xor rax , rax
mov rdi , fmt
mov rsi , [b]
mov rdx , [d]
call printf

xor rbx , rbx
mov r8 , 0
mov [d] , r8
mov rbx , [a]
mov [b] , rbx
mov rcx  , 1
second:
mov [c], rcx
mov rax , qword[a+rcx*8]
mov rdx , [b]
cmp rax , rdx
jl second_con
mov [b],rax
mov rcx , [c]
mov [d] , rcx
second_con:
INC rcx
cmp rcx , 5
jne second

xor rax , rax
mov rdi , fmt
mov rsi , [b]
mov rdx , [d]
call printf


pop RBP
ret


