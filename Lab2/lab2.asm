.MODEL small

.STACK

.DATA
N equ 4
M equ 7
P equ 5
first db 3, 14, -15, 9, 26, -53, 5, 89, 79, 3, 23, 84, -6, 26, 43, -3, 83, 27, -9, 50, 28, -88, 41, 97, -103, 69, 39, -9 
second db 37, -101, 0, 58, -20, 9, 74, 94, -4, 59, -23, 90, -78, 16, -4, 0, -62, 86, 20, 89, 9, 86, 28, 0, -34, 82, 5, 34, -21, 1, 70, -67, 9, 82, 14 
;first db N*M dup(2)
;second db M*P dup(-3)

result dw N*P dup(0)
count db 0
.CODE
.STARTUP 

xor ax, ax 
xor bx, bx
xor cx, cx 
xor dx, dx
xor si, si 
xor di, di
push si
start:  
pop si                                  
push si
push bx
sum:
xor ax, ax
mov al, first[si]
inc si
xor cx, cx
mov cl, second[bx]
add bx, P
imul cl
add result[di], ax 
jo ovf
inc dl
cmp dl, M 
jl sum 
jmp noovf
ovf:
js negat
mov result[di], -32768
jmp noovf
negat:
mov result[di], 32767 
noovf:
add di, 2
pop bx
inc bx 
xor dl, dl
inc dh
cmp dh, P
jl start
pop bx
xor bx,bx
xor dh, dh
push si 
inc count
cmp count, N
jl start
pop si





.EXIT 

END