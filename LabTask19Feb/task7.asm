segment .data
fmt: dq "Vowels: %lld Consonents: %lld ",10,0
ssfmt: dq "%s ",0

segment .bss
s: resb 100
b: resq 1
c: resb 1
d: resb 1
len: resq 2
cnt: resq 2

segment .text
global main
extern scanf
extern gets
extern printf

main:

push RBP
 xor rax , rax
mov rdi , s
call gets

xor rcx , rcx
mov [cnt] ,rcx
mov [len] , rcx

ll:
mov [b] , rcx
mov rcx , [b]
mov bl , [s+rcx]
cmp bl , 0
je _exit
mov bl , [s+rcx]
mov al , 65
cmp bl , al
je count
mov rcx , [b]
mov bl , [s+rcx]
mov al , 69
cmp bl , al
je count
mov rcx , [b]
mov bl , [s+rcx]
mov al , 73
cmp bl , al
je count
mov rcx , [b]
mov bl , [s+rcx]
mov al , 79
cmp bl , al
je count
mov rcx , [b]
mov bl , [s+rcx]
mov al , 85
cmp bl , al
je count

loopCon:
mov rcx , [b]
mov bl , [s+rcx]
cmp bl , 65
jl llcon
mov rax , [len]
add rax , 1
mov [len] , rax
llcon:
mov rcx , [b]
INC rcx
jmp ll
count:
mov rax , [cnt]
add rax , 1
mov [cnt] , rax
jmp loopCon

_exit:
mov rbx ,[cnt]
mov rax , [len]
sub rax , rbx
mov rcx , rax
xor rax , rax
mov rdi, fmt
mov rsi, rbx
mov rdx , rcx
call printf
pop RBP
ret
