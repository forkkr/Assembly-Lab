segment .data
ffmt: dq "First odd number: %lld",10,0
prr: dq "",10,0
sfmt: dq "Last odd number: %lld",10,0
ssfmt: dq "%lld",0

segment .bss
a: resq 255
b: resq 1
c: resq 1
d: resq 1
cnt:  resq 2
now: resq 2
fst: resq 1
snd: resq 1

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
mov qword[a+rbx*8],rax
mov rcx , [b]
INC rcx
cmp rcx , 10
jne ll
; input taken

xor rcx, rcx
mov [cnt] , rcx
sll:
mov [b] , rcx
xor rdx , rdx
mov rax , qword[a+rcx*8]
and rax , 1
cmp rax , 0
je _ex
mov rax , [cnt]
add rax , 1
mov [cnt] , rax
_ex:
mov rcx, [b]
INC rcx
cmp rcx , 10
jne sll

; count done

xor rcx , rcx
mov [now] , rcx
thll:
mov [b] , rcx
mov rax , [a+rcx*8]
and rax , 1
cmp rax , 0
je lpcon
mov rax , [now]
add rax , 1
mov [now] , rax
cmp rax , 1
je _en1
mov rbx ,[cnt]
cmp rax , rbx
je _en2

lpcon:
mov rcx, [b]
INC rcx
cmp rcx , 10
je _exit
jmp thll
_en1:
mov rcx , [b]
mov rax , [a+rcx*8]
mov [fst] , rax
mov [snd] , rax
jmp lpcon
_en2:
mov rcx , [b]
mov rax , [a+rcx*8]
mov [snd] , rax
jmp lpcon
_exit:
mov rdi , ffmt
mov rsi, [fst]
call printf
xor rax , rax
mov rdi , prr
call printf
xor rax , rax
mov rdi , sfmt
mov rsi , [snd]
call printf

pop RBP
ret
