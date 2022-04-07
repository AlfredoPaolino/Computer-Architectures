.MODEL small  

.STACK  

.DATA
first_line DB 50+1 DUP(?)
maiuscole DB 26 DUP(0)
minuscole DB 26 DUP(0)  
.CODE
  
.STARTUP
mov cx, 0
savestr:
cmp cx, 20      ; if count<20 doesn't look for 'enter'
jl savechar 
cmp cx, 50      ; if count=50 the string is full
je endstr
cmp al, 13         ; if the char is 'enter' ends loop
je endstr
savechar: 
mov ah, 1h         ; keyboard input subprogram
int 21h            ; read character into al 
mov di, cx
mov first_line[di], al  ; copy character to string
inc cx 
jmp savestr 
endstr:  
mov di, cx
mov first_line[di], 0 ;add the string terminator

mov cx, 0 
mov dx, 0    
occ:
mov si, cx
mov dl, first_line[si]
mov di, dx 
inc cx
cmp di, 0
je endocc 
cmp di, 'A' 
jl occ  
cmp di, 'z'
ja occ
cmp di, 'Z'
jle maiusc
cmp di, 'A'
jae minusc
jmp occ
maiusc:
sub di, 'A' 
inc maiuscole[di]
jmp occ
minusc:
sub di, 'a'        
inc minuscole[di]
jmp occ
endocc:
  
mov dx, 0        ;dl lettera max, dh numero max
mov cx, 0
mov ax, 0
maxcharmaiusc:
cmp cx, 26
je endmaxchar
mov si, cx
inc cx
mov al, maiuscole[si]
cmp al, dh
jle maxcharminusc
mov dx, si
add dx, 'A'
mov dh, al
maxcharminusc:
mov al, minuscole[si]
cmp al, dh
jle maxcharmaiusc    
mov dx, si
add dx, 'a'
mov dh, al 
jmp maxcharmaiusc
endmaxchar:
mov ah, 2h
int 21h
mov dl, ' '
int 21h
mov ax,0
mov al, dh
mov bh, 10
div bh
cmp al, 0
je onedigit1
push ax
mov dl, al
add dl, '0'
mov ah, 2h
int 21h
pop ax 
onedigit1:
push ax
mov dl, ah
add dl, '0'
mov ah, 2h
int 21h
pop ax

mov ax, 0
mov al, dh
mov bx, 2
div bl 
mov cx, 0 
mov dx, 0
charhalfmax:
cmp cx, 26
je endcharhalfmax
mov si, cx
inc cx
mov dl, maiuscole[si]
cmp dl, al
jl halfminuscole
ja nocarry1
cmp ah, 1
je halfminuscole
nocarry1:
push ax
push dx
mov dx, si
add dx, 'A'
mov ah, 2h
int 21h
mov dl, ' '
int 21h
pop dx
mov ax,0
mov al, dl
mov bh, 10
div bh
cmp al, 0
je onedigit2
push ax
mov dl, al
add dl, '0'
mov ah, 2h
int 21h
pop ax 
onedigit2:
push ax
mov dl, ah
add dl, '0'
mov ah, 2h
int 21h
pop ax
pop ax
halfminuscole:
mov dl, minuscole[si]
cmp dl, al
jl charhalfmax 
ja nocarry2
cmp ah, 1
je charhalfmax
nocarry2:
push ax
push dx
mov dx, si
add dx, 'a'
mov ah, 2h
int 21h
mov dl, ' '
int 21h
pop dx
mov ax,0
mov al, dl
mov bh, 10
div bh
cmp al, 0
je onedigit3
push ax
mov dl, al
add dl, '0'
mov ah, 2h
int 21h
pop ax 
onedigit3:
push ax
mov dl, ah
add dl, '0'
mov ah, 2h
int 21h 
pop ax
pop ax
jmp charhalfmax
endcharhalfmax:

.EXIT 

END