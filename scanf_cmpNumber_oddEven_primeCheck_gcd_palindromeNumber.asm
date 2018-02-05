segment .data
;a: dq 100
;b: dq 2
se: dw "Palindrome",10,0
fi: dw "Not Palindrome",10, 0
fmt: dq "%lld ",10,0
sfmt: dq "%lld %lld",0
ssfmt: dq "%lld",0
strfmt: dq "%s",10,0

segment .bss
a: resq 1
b: resq 1
c: resq 1
d: resq 1

segment .text
global main
extern printf
extern scanf

main:
push RBP

mov rdi , ssfmt
mov rsi, a
call scanf

mov rax , [a]
mov rbx , 10
mov rcx , 0

ll:
xor rdx , rdx
div rbx

mov r8 , rax
mov rax , rcx
mov rcx , rdx
mov rdx , rbx
mul rdx

add rax , rcx
mov rcx , rax
mov rax , r8
push rdx
push rax
push rcx
xor rax , rax
mov rdi , fmt
mov rsi , rcx
call printf
pop rcx
pop rax
pop rdx
cmp rax , 0
je _ex
JMP ll

_ex:
mov rax , [a]
cmp rax , rcx
je palin
mov rdi , strfmt
mov rsi, fi
xor rax , rax
call printf
ret

palin:
mov rdi , strfmt
mov rsi, se
xor rax , rax
call printf
ret


;mov rdx, 0
;mov rax ,[a]
;mov rbx ,[b]
;ll:
;cmp rbx , 0
;je pp
;xor rdx , rdx
;div rbx
;mov rax , rbx
;mov rbx , rdx
;JMP ll
;pp:
;mov rsi, rax
;mov rdi , fmt
;xor rax , rax
;call printf
;ret



;
;div rbx
;mov rcx , rax
;mov rbx , 2
;mov rax , [a]
;cmp rax , 2
;je pr1
;cmp rax, 1
;je pr
;lp:
;mov rdi , fmt
;mov rsi , rcx
;push rcx
;push rbx
;xor rax , rax
;call printf
;pop rbx
;pop rcx
;DEC rcx
;cmp rbx , rcx
;xor rdx , rdx
;mov rax , [a]
;div rbx
;cmp rdx , 0
;je pr
;INC RBX
;DEC rcx
;jnz lp
;pr1:
;mov rdi , strfmt
;mov rsi , se
;xor rax , rax
;call printf
;ret

;pr:
;mov rdi , strfmt
;mov rsi , fi
;xor rax , rax
;call printf
;ret


;mov rax, [a]
;and rax , [b]
;cmp rax, 0
;je even
;mov RDI , fmt
;mov RSI , se
;mov rdx , [a]
;call printf
;ret

;even:
;mov RDI , fmt
;mov RSI , fi
;mov rdx , [a]
;call printf
;ret

;mov rdi, sfmt
;mov rsi, a
;mov rdx, b
;call scanf

;mov rax, [a]
;mov rbx, [b]
	

;CMP rax , rbx
;jg p1
;mov RDI, fmt
;mov RSI, se
;mov RDX, [b]
;mov RAX , 0
;call printf
;JMP _exit

;p1:
;mov RDI, fmt
;mov RSI, fi
;mov RDX, [a]
;mov RAX , 0
;call printf

_exit:
mov RAX, 0
pop RBP
ret
