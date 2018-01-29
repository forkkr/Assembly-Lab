segment .data
a: dq 10
b: dq 11
mul: dw "Product" ,10 , 0
fmt: dq "%s %lld\n", 10, 0


segment .text
global main
extern printf

main:
push RBP

mov RAX , [a]
mov RDX, [b]
mul RDX	
mov RDI, fmt
mov RSI, mul
mov RDX, RAX
mov RAX , 0
call printf

pop RBP
ret 
