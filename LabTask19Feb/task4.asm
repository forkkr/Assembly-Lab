segment .data
fmt: dq "Third largest number: %lld ",10,0
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
first:
mov [b] , rbx
xor rcx , rcx
second:
mov [c] , rcx

mov rbx , [b]
mov rcx , [c]
mov rax , [a+rbx*8]
mov rdx , [a+rcx*8]

cmp rax , rdx
jg second_con

mov rbx , [b]
mov rcx , [c]
mov rax , [a+rbx*8]
mov rdx , [a+rcx*8]

mov [a+rbx*8] , rdx
mov [a+rcx*8] , rax

second_con:
mov rcx , [c]
INC rcx
cmp rcx , 5
jne second

first_con:
mov rbx , [b]
INC rbx
cmp rbx , 5
jne first

xor rcx , rcx
mov rcx , 2
xor rax , rax
mov rdi , fmt
mov rsi , [a+rcx*8]
call printf

pop RBP
ret
