segment .data
a: dq 1110000000000
b: dq 11
c: dq 0
div: dw "Quotient:", 10, 0
fmt: dq "%s %lld %lld", 10, 0

segment .text
global main
extern printf

main:
push RBP

mov RDX, [c]
mov RAX, [a]
mov RBX, [b]
div RBX
mov RCX , RDX
mov RDI, fmt
mov RSI, div
mov RDX, RAX
mov RAX, 0
call printf

pop RBP
ret
