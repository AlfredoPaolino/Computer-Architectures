.model small
.stack
.data
SOURCE db 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 7, 7, 7, 7, 7

.code
.startup
    mov cx, 25
    xor ax, ax
    xor dx, dx 
    xor si, si
    
c1: mov dl, SOURCE[si] 
    add ax, dx
    inc si
    loop c1
    
    xor si, si
    xor dx, dx
    mov cx, 5           
              
c2: mov dl,  SOURCE[si]
    shl dx, 1
    sub ax, dx 
    add si, 6
    loop c2
    

.exit

end