segment .data
fmt: dq "Vowels %lld Consonents %lld ",10,0
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
mov rdi , ssfmt
mov rsi , s
call scanf

xor rcx , rcx
mov [cnt] ,rcx
mov [len] , rcx

ll:
mov [b] , rcx
mov rcx , [b]
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
cmp bl , 0
je _exit
loopCon:
mov rcx , [b]
INC rcx
jmp ll
count:
mov rax , [cnt]
mov rax , 1
mov [cnt] , rax
jmp loopCon

_exit:
mov rbx ,[cnt]
mov rax , [b]
sub rax , rbx
mov rcx , rax
xor rax , rax
mov rdi, fmt
mov rsi, rbx
mov rdx , rcx
call printf
pop RBP
ret

