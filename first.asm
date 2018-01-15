segment .data
a: dq 100
b: dq 200
sum: dw "sum",10,0
fmt: dq "%s %lld ",10,0

segment .text
global main
extern printf

main:
push RBP

mov RAX , 0
mov RAX, [a]
add RAX, [b]
mov RDI, fmt
mov RSI, [a]
mov RDX, RAX
mov RAX , 0
call printf

mov RAX, 0
pop RBP
ret
